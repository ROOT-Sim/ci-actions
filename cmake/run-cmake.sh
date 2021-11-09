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

    mkdir -p $INPUT_BUILD_DIR
    cd $INPUT_BUILD_DIR
    export CC=$INPUT_CC
    export CXX=$INPUT_CXX
    cmake -DCMAKE_BUILD_TYPE=$INPUT_BUILD_TYPE -DCMAKE_C_FLAGS="$INPUT_CFLAGS" -DCMAKE_CXX_FLAGS="$INPUT_CXXFLAGS" $INPUT_SOURCE_DIR
    make $INPUT_TARGET

    if [ "$INPUT_RUN_TESTS" = "true" ]; then
      ctest
    fi
    ;;

  *)
    echo "Unknown platform:" $(uname)
    exit 1
    ;;
esac
