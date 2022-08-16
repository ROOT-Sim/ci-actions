#!/bin/bash
# SPDX-FileCopyrightText: 2008-2021 HPDCS Group <rootsim@googlegroups.com>
# SPDX-License-Identifier: GPL-3.0-only
set -eu

if [ "$(uname)" = "Darwin" ]; then
  if [ "$INPUT_CC" = "gcc" ]; then
    INPUT_CC="gcc-10"
  fi
  if [ "$INPUT_CXX" = "g++" ]; then
    INPUT_CXX="g++-10"
  fi
fi

case $(uname) in
  Windows* | MINGW* | MSYS*)
    export MPI_HOME="/c/Program Files (x86)/Intel/oneAPI/mpi"
    export VERBOSE=1
    ;;

  *)
    ;;
esac

case $(uname) in
  Linux | Darwin | Windows* | MINGW* | MSYS*)
    mkdir -p "$INPUT_BUILD_DIR"
    cd "$INPUT_BUILD_DIR"
    cmake --trace-source=FindMPI.cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER=$INPUT_CC -DCMAKE_CXX_COMPILER=$INPUT_CXX -DCMAKE_BUILD_TYPE="$INPUT_BUILD_TYPE" -DCMAKE_C_FLAGS="$INPUT_CFLAGS" -DCMAKE_CXX_FLAGS="$INPUT_CXXFLAGS" "$INPUT_SOURCE_DIR"
    cmake --build . --config "$INPUT_BUILD_TYPE" --target "$INPUT_TARGET"
    if [ "$INPUT_RUN_TESTS" = "true" ]; then
      ctest --rerun-failed --output-on-failure
    fi
    ;;

  *)
    echo "Unknown platform: $(uname)"
    exit 1
    ;;
esac
