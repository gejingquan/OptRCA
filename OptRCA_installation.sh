#!/bin/bash

AURORA_GIT_DIR="$(pwd)/aurora"
cd evaluation
EVAL_DIR=`pwd`
AFL_DIR=$EVAL_DIR/afl-fuzz
AFL_WORKDIR=$EVAL_DIR/afl-workdir
mkdir -p $EVAL_DIR/inputs/crashes
mkdir -p $EVAL_DIR/inputs/non_crashes


cd $EVAL_DIR/afl-fuzz
make -j
cd ..


git clone https://github.com/mruby/mruby.git
cd mruby
git checkout e9ddb593f3f6c0264563eaf20f5de8cf43cc1c5d
CC=$AFL_DIR/afl-gcc CFLAGS="-fsanitize=address -fsanitize-recover=address -ggdb -O0" LDFLAGS="-fsanitize=address"  make -e -j
mv ./bin/mruby ../mruby_fuzz
make clean
CFLAGS="-ggdb -O0" make -e -j
mv ./bin/mruby ../mruby_trace
cd $EVAL_DIR
echo "@@" > arguments.txt


wget -c http://software.intel.com/sites/landingpage/pintool/downloads/pin-3.15-98253-gb56e429b1-gcc-linux.tar.gz
tar -xzf pin*.tar.gz
export PIN_ROOT="$(pwd)/pin-3.15-98253-gb56e429b1-gcc-linux"
mkdir -p "${PIN_ROOT}/source/tools/AuroraTracer"
cp -r ${AURORA_GIT_DIR}/tracing/* ${PIN_ROOT}/source/tools/AuroraTracer
cd ${PIN_ROOT}/source/tools/AuroraTracer
make obj-intel64/aurora_tracer.so
cd -
mkdir -p $EVAL_DIR/traces



