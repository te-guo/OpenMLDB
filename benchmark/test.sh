#!/bin/bash

rm -f ready_to_perf
sh call_perf.sh &
java -cp conf/:lib/* com._4paradigm.openmldb.benchmark.OpenMLDBPerfBenchmark
cd /root/OpenMLDB/openmldb
sbin/stop-tablets.sh