exec_path="../cmake-build-debug-remote/db_bench"
db_path="/nvme/fillseq_11"
$exec_path   --benchmarks="fillseq,stats" --statistics --db=$db_path --perf_level=3  \
--key_size=48 -value_size=43 --histogram \
--use_direct_reads=true --cache_size=268435456 \
--use_direct_io_for_flush_and_compaction=true \
--num=50000000 -report_interval_seconds=1
#-report_file=result/fillrandom.csv

#./db_bench –benchmarks=fillrandom –perf_level=3
#-use_direct_io_for_flush_and_compaction=true -
#use_direct_reads=true -cache_size=268435456 -key_size=48
#-value_size=43 -num=50000000 -db=./<Directory of
#Generated Database with 50 million KV-pairs>
