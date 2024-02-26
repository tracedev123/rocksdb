exec_path="../cmake-build-debug/db_bench"


db_path="/tmp/block_cache_trace"
$exec_path --benchmarks=fillrandom -db=$db_path \
--use_direct_io_for_flush_and_compaction=true --use_direct_reads=true \
--cache_size=268435456 --key_size=48 --value_size=43 --num=5000000 \
--disable_auto_compactions=1 --disable_wal=1 --compression_type=none \
--num_column_families=5 --perf_level=3


