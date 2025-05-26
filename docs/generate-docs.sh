#!/bin/bash
# SPDX-FileCopyrightText: 2008-2025 HPCS Group <rootsim@googlegroups.com>
# SPDX-License-Identifier: GPL-3.0-only
set -eu

case $(uname) in
  Linux)
    mkdir build
    cd build
    cmake -DDOXYGEN_INPUT_FILTER=$GITHUB_ACTION_PATH/doxygen_spdx_filter.py -DDOXYGEN_GENERATE_XML=YES ..
    cmake --build . --target $TARGET
    ;;

  Darwin | Windows* | MINGW* | MSYS*)
    echo "This action is expected to run only in Linux"
    ;;

  *)
    echo "Unknown platform:" $(uname)
    exit 1
    ;;
esac
