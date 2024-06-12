#!/bin/bash

# Function to calculate the percentage of zeros in a file
calculate_percentage_zeros() {
    file="$1"
    total_count=$(wc -l < "$file")
    zero_count=$(grep -c '0' "$file")
    echo "$zero_count" >> "$trace_data_dir/cache_hit.txt"
}

exec_path="../cmake-build-debug/db_bench"
db_base_path="/tmp/db"
trace_analyzer_exec="../cmake-build-debug/trace_analyzer"
trace_data_base_dir="../trace_data_dir_2/dir"
bct_path="../cmake-build-debug/block_cache_trace_analyzer"


readwritepercent_values=(80)
value_size_values=(10 43 128 256)
num_values=(10000000 5000000)
deletepercent_values=(5)

for val_size in "${value_size_values[@]}"; do
  for num_val in "${num_values[@]}"; do
    for rw_percent in "${readwritepercent_values[@]}"; do
      for delete_percent in "${deletepercent_values[@]}"; do
        # Delete existing db and create new db path
        db_path="${db_base_path}_${rw_percent}_${val_size}_${num_val}_${delete_percent}"

        # Create new directory for trace_data_dir
        trace_data_dir="${trace_data_base_dir}_${rw_percent}_${val_size}_${num_val}_${delete_percent}"
        mkdir -p "$trace_data_dir"

        # Run fillrandom benchmark
        $exec_path --benchmarks="fillrandom" --db="$db_path" --perf_level=3 \
        --key_size=48 --value_size="$val_size" --threads=8 \
        --use_direct_reads=true --cache_size=268435456 \
        --use_direct_io_for_flush_and_compaction=true \
        --num=6250000

        # Run randomwithverify benchmark
        $exec_path --benchmarks="readrandomwriterandom,stats" --use_existing_db=true --db="$db_path" \
        --key_size=48 --value_size="$val_size" --perf_level=3 --statistics \
        --use_direct_io_for_flush_and_compaction=true --use_direct_reads=true \
        --readwritepercent="$rw_percent" --cache_size=268435456  \
        --num="$num_val" -trace_file="/tmp/op_trace_file_dbbench" > "$trace_data_dir/statistics.txt"

        # Analyze traces
        $trace_analyzer_exec \
        -analyze_get \
        -analyze_put \
        -analyze_delete \
        -analyze_iterator \
        -analyze_merge \
        -analyze_multiget \
        -analyze_range_delete \
        -analyze_single_delete \
        -output_dir="$trace_data_dir" \
        -output_ml_features \
        -trace_path="/tmp/op_trace_file_dbbench" > "$trace_data_dir/qlt.txt"

        # Analyze block cache traces if not disabled
        if [ -z $disable_bcp ]; then
          bct_human_file_path="$trace_data_dir/bct_human_readable_file"
          bct_output_path="$trace_data_dir/summary.txt"
          $bct_path \
          -block_cache_trace_path="/tmp/block_cache_trace_file_dbbench" \
          -human_readable_trace_file_path="$bct_human_file_path" \
          -print_access_count_stats > "$bct_output_path"
        fi

        calculate_percentage_zeros "$bct_human_file_path"

        ../io_tracer_parser -io_trace_file="/tmp/io_trace_file_dbbench" >  "$trace_data_dir/io_trace_file.txt"

        rm -rf "$db_path"
      done
    done
  done
done
