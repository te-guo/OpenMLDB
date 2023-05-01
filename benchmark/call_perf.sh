#!/bin/bash

while [ ! -f ready_to_perf ]
do
    sleep 1
done

cd /tmp/openmldb/tablet-1
PID1="$(tr -d '\0' < ./bin/tablet.pid)"
perf record --call-graph dwarf -a -F 99 -e task-clock -p "$PID1" &
echo "perf record -p $PID1 ... ($!)"
cd /tmp/openmldb/tablet-2
PID2="$(tr -d '\0' < ./bin/tablet.pid)"
perf record --call-graph dwarf -a -F 99 -e task-clock -p "$PID2" &
echo "perf record -p $PID2 ... ($!)"