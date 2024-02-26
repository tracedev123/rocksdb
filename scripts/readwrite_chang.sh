
../cmake-build-debug-remote/db_bench --benchmarks="readrandomwriterandom,stats" --statistics --histogram --use_existing_db=true --db="/nvme/fillseq_10" \
--use_direct_io_for_flush_and_compaction=true --use_direct_reads=true --cache_index_and_filter_blocks=true --perf_level=3 --key_size=48 --value_size=43  \
--readwritepercent=90 --cache_size=268435456 --statistics \
--num=1000000
#-trace_file="/tmp/op_trace_file_dbbench"

