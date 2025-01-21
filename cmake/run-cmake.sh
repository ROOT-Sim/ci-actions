#!/bin/bash
# SPDX-FileCopyrightText: 2008-2021 HPDCS Group <rootsim@googlegroups.com>
# SPDX-License-Identifier: GPL-3.0-only
set -eu

# Use a different gcc name on MacOS
if [ "$(uname)" = "Darwin" ]; then
  if [ "$INPUT_CC" = "gcc" ]; then
    INPUT_CC="gcc-14"
  fi
  if [ "$INPUT_CXX" = "g++" ]; then
    INPUT_CXX="g++-14"
  fi
fi

# In contrast to other generators (like Makefiles or Ninja) CMake does not generate an all target for Visual Studio solution
# but an ALL_BUILD target.
case $(uname) in
Windows* | MINGW* | MSYS*)
  if [ "$INPUT_TARGET" = "all" ]; then
    INPUT_TARGET="ALL_BUILD"
  fi
;;
esac


mkdir -p "$INPUT_BUILD_DIR"
cd "$INPUT_BUILD_DIR"

case $(uname) in
Linux | Darwin)
  "${GITHUB_ACTION_PATH}"/run-cmake-helper.sh
  ;;

Windows* | MINGW* | MSYS*)
  "${I_MPI_ROOT}"/env/vars.bat
  cmake -G "Visual Studio 17 2022" -A x64 -DCMAKE_C_COMPILER="$INPUT_CC" -DCMAKE_CXX_COMPILER="$INPUT_CXX" -DCMAKE_BUILD_TYPE="$INPUT_BUILD_TYPE" -DCMAKE_C_FLAGS="$INPUT_CFLAGS" -DCMAKE_CXX_FLAGS="$INPUT_CXXFLAGS" "$INPUT_SOURCE_DIR"
  ;;
*)

  echo "Unknown platform: $(uname)"
  exit 1
  ;;
esac

cmake --build . --config "$INPUT_BUILD_TYPE" --target "$INPUT_TARGET"
if [ "$INPUT_RUN_TESTS" = "true" ]; then
  ctest --rerun-failed --output-on-failure
fi
