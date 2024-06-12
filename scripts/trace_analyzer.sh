trace_analyzer_exec="../cmake-build-debug/trace_analyzer"
trace_data_dir="../trace_data_dir/burner_3"
key_space_dir="../trace_data_dir/burner_3"

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
  -trace_path="/tmp/op_trace_file_dbbench" \

#while [[ $# -gt 0 ]]; do
#  case $1 in
#    --disable_bcp)
#      disable_bcp=1
#      shift
#      shift
#      ;;
#  esac
#done

#trace_data_dir="../trace_data_dir/rw_12_3"


#block_trace_file_path="$trace_data_dir/block_cache_trace_file"
#
#if [ -z $disable_bcp ]; then
#bct_path="../cmake-build-debug/block_cache_trace_analyzer"
#bct_human_file_path="$trace_data_dir/bct_human_readable_file"
#$bct_path \
# -block_cache_trace_path="/tmp/block_cache_trace_file_dbbench"\
# -human_readable_trace_file_path="$bct_human_file_path" \
# -print_access_count_stats
#fi
