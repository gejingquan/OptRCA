This is the source code repository of OptRCA. OptRCA is a more powerful root cause analysis tool that is optimized and improved based on [AURORA](https://github.com/RUB-SysSec/aurora). Next, we will explain how to use OptRCA to perform root cause analysis on a crash test case.


First, run the OptRCA_prepare.sh script to prepare the application binary (mruby) and the Intel Pin analysis tool for analysis.

```
git clone https://github.com/gejingquan/OptRCA
cd OptRCA
./RCA_prepare.sh
```

Second, perform the following as root to prepare fuzz.

```
echo core >/proc/sys/kernel/core_pattern
cd /sys/devices/system/cpu
echo performance | tee cpu*/cpufreq/scaling_governor
echo 0 | tee /proc/sys/kernel/randomize_va_space
```

Third, set the necessary variables and start fuzz.

```
source initialization.sh
timeout 43200 $AFL_DIR/afl-fuzz -C -d -m none -i $EVAL_DIR/seed -o $AFL_WORKDIR -- $EVAL_DIR/mruby_fuzz @@
```



