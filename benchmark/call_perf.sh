#!/bin/bash

while [ ! -f ready_to_perf ]
do
    sleep 1
done

cd /tmp/openmldb/tablet-1
PID1="$(tr -d '\0' < ./bin/tablet.pid)"
perf record --call-graph dwarf -a -F 100 -e task-clock -p "$PID1" &
perf stat -d -p "$PID1" 2> perf_stat_result_1.txt &
echo "perf record -p $PID1 ... ($!)"
cd /tmp/openmldb/tablet-2
PID2="$(tr -d '\0' < ./bin/tablet.pid)"
perf record --call-graph dwarf -a -F 100 -e task-clock -p "$PID2" &
perf stat -d -p "$PID2" 2> perf_stat_result_2.txt &
echo "perf record -p $PID2 ... ($!)"