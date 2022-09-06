#!/bin/sh
cairo-compile ./src/test.cairo --output ./build/atest_compiled.json

cairo-run \
  --program=./build/atest_compiled.json --print_output \
  --print_info --relocate_prints