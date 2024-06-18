exec_path="../cmake-build-debug/db_bench"
db_path="/tmp/readrandom_db"

trace_data_dir="../complete_traces/readrandom"
key_space_dir="../complete_traces/readrandom"
#calculate_percentage_zeros() {
#    file="$1"
#    total_count=$(wc -l < "$file")
#    zero_count=$(grep -c '0' "$file")
#    percentage_zeros=$(bc <<< "($zero_count / $total_count)")
#    echo "Count of 0 $zero_count \n"
#    echo "Percentage of 0 $percentage_zeros \n"
#    echo "$percentage_zeros" >> "$trace_data_dir/cache_hit.txt"
#}

# Run fillrandom benchmark
$exec_path --benchmarks="fillrandom" --db="$db_path" --perf_level=3 \
--key_size=48 --value_size=43 --threads=1 \
--use_direct_reads=true --cache_size=268435456 \
--use_direct_io_for_flush_and_compaction=true \
--num=1000000
#
##
#../cmake-build-debug/db_bench --benchmarks="readrandom,stats" --use_existing_db=true --db="$db_path" \
#--key_size=48 --value_size=43 --perf_level=3 --statistics --num_column_families=3 \
#--use_direct_io_for_flush_and_compaction=true --use_direct_reads=true \
#--cache_size=268435456  \
#--num=2000000 -trace_file="/tmp/op_trace_file_dbbench" > "$trace_data_dir/statistics.txt"

../build/db_bench --benchmarks="readrandomwriterandom,stats" --use_existing_db=true --db="$db_path" \
--key_size=48 --value_size=43 --perf_level=3 --statistics  \
--use_direct_io_for_flush_and_compaction=true --use_direct_reads=true \
--readwritepercent=85 --cache_size=268435456  \
--num=2000000 -trace_file="/tmp/op_trace_file_dbbench" > "$trace_data_dir/statistics.txt"

#$exec_path --benchmarks="mixgraph,stats" --use_direct_io_for_flush_and_compaction=true -db=$db_path \
#--use_direct_reads=true --cache_size=268435456 --keyrange_dist_a=14.18 --keyrange_dist_b=-2.917 \
#--keyrange_dist_c=0.0164 --keyrange_dist_d=-0.08082 --keyrange_num=30 --value_k=0.2615 --statistics \
#--value_sigma=25.45 --iter_k=2.517 --iter_sigma=14.236 --mix_get_ratio=0.85 --mix_put_ratio=0.14 \
#--mix_seek_ratio=0.00 --sine_mix_rate_interval_milliseconds=5000 --sine_a=1000 --sine_b=0.000000073 \
#--sine_d=4500000 --perf_level=1 --reads=4200000 --num=50000000 --key_size=48 \
#--statistics=1 --duration=300  > "$trace_data_dir/statistics.txt"

#$exec_path --benchmarks="randomwithverify" --use_existing_db=true --db=$db_path \
#--key_size=48 --value_size=43 --perf_level=3 --num_column_families=3 \
#--use_direct_io_for_flush_and_compaction=true --use_direct_reads=true \
#--readwritepercent=10 --deletepercent=5 --cache_size=268435456  \
#--num=10000000 -trace_file="/tmp/op_trace_file_dbbench"


trace_analyzer_exec="../cmake-build-debug/trace_analyzer"


$trace_analyzer_exec \
  -analyze_get \
  -analyze_put \
  -analyze_delete \
  -analyze_iterator \
  -analyze_merge \
  -analyze_multiget \
  -analyze_range_delete \
  -analyze_single_delete \
  -convert_to_human_readable_trace \
  -key_space_dir="$key_space_dir" \
  -output_key_distribution  \
  -output_access_count_stats \
  -output_dir="$trace_data_dir" \
  -output_key_stats \
  -output_qps_stats \
  -output_value_distribution \
  -print_overall_stats \
  -print_top_k_access=5 \
  -output_ml_features \
  -trace_path="/tmp/op_trace_file_dbbench" \
  > "$trace_data_dir/qlt.txt"

#while [[ $# -gt 0 ]]; do
#  case $1 in
#    --disable_bcp)
#      disable_bcp=1
#      shift
#      shift
#      ;;
#  esac
#done
#
#
#block_trace_file_path="$trace_data_dir/block_cache_trace_file"
#
#if [ -z $disable_bcp ]; then
#bct_path="../cmake-build-debug/block_cache_trace_analyzer"
#bct_human_file_path="$trace_data_dir/bct_human_readable_file"
#bct_output_path="$trace_data_dir/summary.txt"
#$bct_path \
# -block_cache_trace_path="/tmp/block_cache_trace_file_dbbench"\
# -human_readable_trace_file_path="$bct_human_file_path" \
# -print_access_count_stats > "$bct_output_path"
#fi
#
#../io_tracer_parser -io_trace_file="/tmp/io_trace_file_dbbench" > "$trace_data_dir/io_trace_file.txt"

#calculate_percentage_zeros "$bct_human_file_path"
