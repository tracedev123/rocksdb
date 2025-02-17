#../cmake-build-debug/db_bench --benchmarks="fillseq" \
#--key_size=20 --prefix_size=20 --keys_per_prefix=0 --value_size=100 \
#--cache_index_and_filter_blocks --cache_size=1048576 \
#--disable_auto_compactions=1 --disable_wal=1 --compression_type=none \
#--min_level_to_compress=-1 --compression_ratio=1 --num=10000000

#while [[ $# -gt 0 ]]; do
#  case $1 in
#    --disable_bcp)
#      disable_bcp=1
#      shift
#      shift
#      ;;
#  esac
#done


exec_path="../cmake-build-debug/db_bench"
db_path="/tmp/db_1"
$exec_path --benchmarks="fillrandom" --db="$db_path" --perf_level=3 \
--key_size=48 --value_size=43 --threads=1 --num_column_families=2 \
--use_direct_reads=true --cache_size=268435456 \
--use_direct_io_for_flush_and_compaction=true \
--num=1000000
#
#trace_data_dir="./trace_data_dir"
#rm -rf "$trace_data_dir"
#if [ ! -e $trace_data_dir ]; then
#  mkdir -p $trace_data_dir
#fi
#
#block_trace_file_path="$trace_data_dir/block_cache_trace_file"
#op_trace_file_path="$trace_data_dir/op_trace_file"
#io_trace_file_path="$trace_data_dir/io_trace_file"
#
#$exec_path --benchmarks="readrandom" --use_existing_db --db=$db_path --duration=60 \
#--key_size=20 --prefix_size=20 --keys_per_prefix=0 --value_size=100 \
#--cache_index_and_filter_blocks --cache_size=1048576 \
#--disable_auto_compactions=1 --disable_wal=1 --compression_type=none \
#--min_level_to_compress=-1 --compression_ratio=1 --num=10000000 \
#--threads=16 \
#-block_cache_trace_file="$block_trace_file_path" \
#-block_cache_trace_max_trace_file_size_in_bytes=1073741824 \
#-block_cache_trace_sampling_frequency=1
##-trace_file="$op_trace_file_path" \
#
##if [ -z $disable_bcp ]; then
##bct_path="../cmake-build-debug/block_cache_trace_analyzer"
##bct_human_file_path="$trace_data_dir/bct_human_readable_file"
##$bct_path \
## -block_cache_trace_path="$block_trace_file_path"\
## -human_readable_trace_file_path="$bct_human_file_path"
##fi
#
#trace_analyzer_exec="../cmake-build-debug/trace_analyzer"
#$trace_analyzer_exec \
#  -analyze_get \
#  -output_access_count_stats \
#  -output_dir="$trace_data_dir" \
#  -output_key_stats \
#  -output_qps_stats \
#  -convert_to_human_readable_trace \
#  -output_value_distribution \
#  -output_key_distribution \
#  -print_overall_stats \
#  -print_top_k_access=3 \
#  -output_prefix=op_trace \
#  -output_time_series \
#  -trace_path="$op_trace_file_path"
#
#
##io_trace_parser_exec="../cmake-build-debug/io_tracer_parser"
##io_parser_res="$trace_data_dir/io_trace_res.log"
##$io_trace_parser_exec -io_trace_file="$io_trace_file_path" >  "$io_parser_res"