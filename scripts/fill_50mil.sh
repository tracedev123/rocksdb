exec_path="../cmake-build-debug/db_bench"
db_path="/tmp/db_40millionkv"
$exec_path --benchmarks=fillrandom --perf_level=3 -db=$db_path \
--use_direct_io_for_flush_and_compaction=true --use_direct_reads=true \
--cache_size=268435456 --key_size=48 --threads=8 \
--value_size=43 --num=5000000
