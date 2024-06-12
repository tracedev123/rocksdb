../cmake-build-debug/db_bench --benchmarks="readrandom" --use_existing_db=true --db="/tmp/db_"  \
--key_size=48 -value_size=43 --perf_level=3 \
--cache_size=8388608 \
--num=1000 \
--threads=1 --use_direct_reads=true --use_direct_io_for_flush_and_compaction=true \
-trace_file="/tmp/op_trace_file_dbbench"




#../cmake-build-debug/db_bench --benchmarks="readrandom" --use_existing_db=true --db="/tmp/db"  \
#--key_size=48 -value_size=43 --perf_level=3 \
#--cache_index_and_filter_blocks --cache_size=268435456 \
#--disable_auto_compactions=1 --disable_wal=1 --compression_type=none \
#--min_level_to_compress=-1 --compression_ratio=1 --num=1000 \
#--threads=1 --use_direct_reads=true --use_direct_io_for_flush_and_compaction=true \
#-block_cache_trace_max_trace_file_size_in_bytes=1073741824 \
#-block_cache_trace_sampling_frequency=1 \
#-trace_file="/tmp/op_trace_file_dbbench"
#--duration=60

#../cmake-build-debug/db_bench --benchmarks="readrandom" --use_existing_db=true --db="/tmp/db" --duration=30 \
#--key_size=48 --num_column_families=5 \
#--cache_size=1048576 --cache_index_and_filter_blocks \
#--num=1000000 \
##-trace_file="/tmp/op_trace_file_dbbench"


#./db_bench –benchmarks="mixgraph" -
#use_direct_io_for_flush_and_compaction=true -
#use_direct_reads=true -cache_size=268435456
#-key_dist_a=0.002312 -key_dist_b=0.3467 -
#keyrange_dist_a=14.18 -keyrange_dist_b=-2.917 -
#keyrange_dist_c=0.0164 -keyrange_dist_d=-0.08082
#-keyrange_num=30 -value_k=0.2615 -value_sigma=25.45
#-iter_k=2.517 -iter_sigma=14.236 -mix_get_ratio=0.83
#-mix_put_ratio=0.14 -mix_seek_ratio=0.03 -
#sine_mix_rate_interval_milliseconds=5000 -sine_a=1000
#-sine_b=0.000073 -sine_d=4500 –perf_level=2 -
#reads=420000000 -num=50000000 -key_size=48 -db=./<
#Directory of Generated Database with 50 million KV-pairs>
#-use_existing_db=true
