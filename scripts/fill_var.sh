#!/bin/bash

# List of write buffer sizes to test
max_write_buffer_numbers=("8")
#max_write_buffer_numbers=("8" "8" "8" "8" "8" "8" "8" "8")

# Path to the db_bench executable
db_bench_path="../cmake-build-debug-remote"


# Path to the directory where you want to store the output files
output_dir="../trace_data_dir/burner_fill_var"

write_num=30000000
write_buffer_size=16777216
target_file_size_base=16777216

# Iterate through write buffer sizes
for size in "${max_write_buffer_numbers[@]}"; do
    db_path="/tmp/gc_test_${size}"
    hdfs dfs -rm -r "${db_path}"
    output_file="${output_dir}/write_buffer_size_${size}.txt"

    echo "Running db_bench in hdfs with max_write_buffer_number = ${size}"

    # Run db_bench with the current write buffer size
#     ${db_bench_path} -benchmarks=fillrandom -max_write_buffer_number=${size} -num=50000000 -db=/tmp/gc_test > ${output_file} 2>&1
    cd "${db_bench_path}"
    db_command="./db_bench -benchmarks=fillrandom -max_write_buffer_number=${size} -num=${write_num} -write_buffer_size=${write_buffer_size} -target_file_size_base=${target_file_size_base} -max_background_flushes=8 -db=${db_path}"
    echo "Running command: ${db_command}"
    eval "${db_command}"



    echo "Finished db_bench in hdfs with max_write_buffer_number = ${size}"
    echo ""
    echo ""
done