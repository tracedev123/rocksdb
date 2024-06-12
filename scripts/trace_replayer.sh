db_path="/tmp/db_1_copy"

trace_data_dir="../burner_traces/trace_2"
key_space_dir="../burner_traces/trace_2"

../cmake-build-debug/db_bench --benchmarks=replay --use_existing_db=true --db="$db_path" \
--use_direct_io_for_flush_and_compaction=true --use_direct_reads=true --perf_level=3 --num_column_families=2 \
--trace_file="/tmp/op_trace_file_dbbench"
#--txt_file=../trace_data_dir/read/trace-human_readable_trace.txt

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

while [[ $# -gt 0 ]]; do
  case $1 in
    --disable_bcp)
      disable_bcp=1
      shift
      shift
      ;;
  esac
done


block_trace_file_path="$trace_data_dir/block_cache_trace_file"

if [ -z $disable_bcp ]; then
bct_path="../cmake-build-debug/block_cache_trace_analyzer"
bct_human_file_path="$trace_data_dir/bct_human_readable_file"
bct_output_path="$trace_data_dir/summary.txt"
$bct_path \
 -block_cache_trace_path="/tmp/block_cache_trace_file_dbbench"\
 -human_readable_trace_file_path="$bct_human_file_path" \
 -print_access_count_stats > "$bct_output_path"
fi

../io_tracer_parser -io_trace_file="/tmp/io_trace_file_dbbench" > "$trace_data_dir/io_trace_file.txt"