exec_path="../cmake-build-debug/db_bench"


db_path="/tmp/db_40millionkv"
$exec_path --benchmarks="mixgraph" --use_direct_io_for_flush_and_compaction=true -db=$db_path \
--use_direct_reads=true --cache_size=268435456 --keyrange_dist_a=14.18 --keyrange_dist_b=-2.917 \
--keyrange_dist_c=0.0164 --keyrange_dist_d=-0.08082 --keyrange_num=30 --value_k=0.2615 \
--value_sigma=25.45 --iter_k=2.517 --iter_sigma=14.236 --mix_get_ratio=0.85 --mix_put_ratio=0.14 \
--mix_seek_ratio=0.01 --sine_mix_rate_interval_milliseconds=5000 --sine_a=1000 --sine_b=0.000000073 \
--sine_d=4500000 --perf_level=1 --reads=4200000 --num=50000000 --key_size=48 \
--statistics=1 --duration=300 -trace_file="/tmp/op_trace_file_dbbench"