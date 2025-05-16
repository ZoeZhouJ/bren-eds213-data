#!/bin/bash

# add arguments
if [ $# -ne 5 ]; then
    echo "Supply 5 arguments: label num_reps query db_file csv_file"
    exit 1
fi

label="$1" # quoted due to space between words
num_reps=$2
query="$3" # quoted due to space between query
db_file=$4
csv_file=$5

# Get current time and store it
start_time="$(date +%s)"
# Loop num_reps times
for i in $(seq "$num_reps"); do
    echo "this is loop iteration $i"
    duckdb "$db_file" "$query" > /dev/null 2>&1 # dont include > ... if we want output
# end loop
done
# Get current time
end_time="$(date +%s)"
# compute elapsed time
elapse_time=$((end_time-start_time)) # (()) for arithmetic
# divide elapsed time by num_reps
average=$(echo "scale=6; $elapse_time/$num_reps" | bc)
# write output
echo "$label, $average" >> "$csv_file"