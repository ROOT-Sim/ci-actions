#!/bin/bash
# SPDX-FileCopyrightText: 2008-2021 HPDCS Group <rootsim@googlegroups.com>
# SPDX-License-Identifier: GPL-3.0-only
set -eu

function prepare() {
  mkdir -p $INPUT_BUILD_DIR
  cd $INPUT_BUILD_DIR
  export CC=$INPUT_CC
  export CXX=$INPUT_CXX
  cmake -DCMAKE_BUILD_TYPE=$INPUT_BUILD_TYPE -DCMAKE_C_FLAGS="$INPUT_CFLAGS" -DCMAKE_CXX_FLAGS="$INPUT_CXXFLAGS" $INPUT_SOURCE_DIR
}

function test() {
  ls
  if [ "$INPUT_RUN_TESTS" = "true" ]; then
    ctest
  fi
}

case $(uname) in
  Linux | Darwin)
    prepare
    cmake --build . --config $INPUT_BUILD_TYPE --target $INPUT_TARGET
    test || cat /Users/runner/work/ci-actions/build/Testing/Temporary/LastTest.log
    ;;

  Windows* | MINGW* | MSYS*)
    prepare
    target=$INPUT_TARGET
    if [ "$target" = "all" ]; then
      target="ALL_BUILD"
    fi
    cmake --build . --config $INPUT_BUILD_TYPE --target $target
    test || cat D:/a/ci-actions/build/Testing/Temporary/LastTest.log
    ;;

  *)
    echo "Unknown platform:" $(uname)
    exit 1
    ;;
esac
