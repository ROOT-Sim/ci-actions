#!/bin/bash
set -eu

case $(uname) in
  Linux | Darwin | Windows* | MINGW* | MSYS*)
    echo $INPUT_SOURCE_DIR
    echo "Build dir: $INPUT_BUILD_DIR"
    echo "Build type: ${INPUT_BUILD_TYPE}"
    echo "CC: ${INPUT_CC}"
    echo "CXX: ${INPUT_CXX}"
    echo "target: ${INPUT_TARGET}"
    echo "Run tests: ${INPUT_RUN_TESTS}"

#    mkdir build
#    cd build
#    cmake ..
    ;;

#-DCMAKE_BUILD_TYPE=
#-DCMAKE_CXX_FLAGS=
#-DCMAKE_C_FLAGS=

  *)
    echo "Unknown platform:" $(uname)
    exit 1
    ;;
esac
