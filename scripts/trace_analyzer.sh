trace_analyzer_exec="../cmake-build-debug-remote/trace_analyzer"
trace_data_dir="../trace_data_dir/fillseq"
$trace_analyzer_exec \
  -analyze_get \
  -analyze_put \
  -analyze_multiget \
  -analyze_iterator \
  -analyze_delete \
  -output_access_count_stats \
  -output_dir="$trace_data_dir" \
  -output_key_stats \
  -output_qps_stats \
  -convert_to_human_readable_trace \
  -print_overall_stats \
  -print_top_k_access=5 \
  -trace_path="/tmp/op_trace_file_dbbench"