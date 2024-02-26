
../cmake-build-debug/db_bench --benchmarks="readrandom,stats" --use_existing_db=true --db="/tmp/gc_test_2" \
--use_direct_io_for_flush_and_compaction=true --use_direct_reads=true --cache_index_and_filter_blocks=true --perf_level=2 --key_size=48 --value_size=10240  \
--cache_size=268435456 --statistics \
--num=1000000
#-trace_file="/tmp/op_trace_file_dbbench"

