#!/bin/bash

AURORA_GIT_DIR="$(pwd)/aurora"
cd evaluation
EVAL_DIR=`pwd`
AFL_DIR=$EVAL_DIR/afl-fuzz
AFL_WORKDIR=$EVAL_DIR/afl-workdir
export PIN_ROOT="$(pwd)/pin-3.15-98253-gb56e429b1-gcc-linux"




