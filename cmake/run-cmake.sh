#!/bin/bash
set -eu

function prepare() {
  mkdir -p $INPUT_BUILD_DIR
  cd $INPUT_BUILD_DIR
  export CC=$INPUT_CC
  export CXX=$INPUT_CXX
  cmake -DCMAKE_BUILD_TYPE=$INPUT_BUILD_TYPE -DCMAKE_C_FLAGS="$INPUT_CFLAGS" -DCMAKE_CXX_FLAGS="$INPUT_CXXFLAGS" $INPUT_SOURCE_DIR
}

function test() {
  if [ "$INPUT_RUN_TESTS" = "true" ]; then
    ctest
  fi
}

case $(uname) in
  Linux | Darwin)
    prepare
    cmake --build . --config $INPUT_BUILD_TYPE --target $INPUT_TARGET

    test
    ;;

  Windows* | MINGW* | MSYS*)
    prepare
    ls
    target=$INPUT_BUILD_TYPE
    if [ "$target" = "all" ]; then
      target="all_build"
    fi
    cmake --build . --config $INPUT_BUILD_TYPE --target $target
    test
    ;;

  *)
    echo "Unknown platform:" $(uname)
    exit 1
    ;;
esac
