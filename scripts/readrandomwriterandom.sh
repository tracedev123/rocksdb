
db_path="/tmp/db"

#../cmake-build-debug/db_bench --benchmarks="readrandomwriterandom,stats" --statistics --histogram --use_existing_db=true --db="/tmp/db" --duration=30 \
#--num_column_families=5 --key_size=20 --prefix_size=20 --keys_per_prefix=0 --value_size=100 \
#--cache_index_and_filter_blocks --cache_size=1048576 \
#--disable_auto_compactions=1 --disable_wal=1 --compression_type=none \
#--min_level_to_compress=-1 --compression_ratio=1 --num=1000000 \
#--threads=1 \
#-block_cache_trace_max_trace_file_size_in_bytes=1073741824 \
#-block_cache_trace_sampling_frequency=1 \
##-trace_file="/tmp/op_trace_file_dbbench"

../cmake-build-debug/db_bench --benchmarks="readrandomwriterandom,stats" --use_existing_db=true --db="/tmp/db" --num_column_families=5 \
--prefix_size=20 --keys_per_prefix=0 --threads=1 \
--use_direct_io_for_flush_and_compaction=true --use_direct_reads=true --cache_index_and_filter_blocks=true --perf_level=2 --key_size=20 --value_size=100  \
--readwritepercent=90 --cache_size=1048576 --statistics \
--num=2000

