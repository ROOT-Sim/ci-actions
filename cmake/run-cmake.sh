#!/bin/bash
# SPDX-FileCopyrightText: 2008-2021 HPDCS Group <rootsim@googlegroups.com>
# SPDX-License-Identifier: GPL-3.0-only
set -eu

if [ "$(uname)" = "Darwin" ]; then
  if [ "$INPUT_CC" = "gcc" ]; then
    INPUT_CC="gcc-11"
  fi
  if [ "$INPUT_CXX" = "g++" ]; then
    INPUT_CXX="g++-11"
  fi
fi

mkdir -p "$INPUT_BUILD_DIR"
cd "$INPUT_BUILD_DIR"

case $(uname) in
Linux | Darwin)
  "${GITHUB_ACTION_PATH}"/run-cmake-helper.sh
  ;;

Windows* | MINGW* | MSYS*)
  "${GITHUB_ACTION_PATH}"/run-cmake-helper.sh
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
