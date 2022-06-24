#!/bin/bash
# SPDX-FileCopyrightText: 2008-2021 HPDCS Group <rootsim@googlegroups.com>
# SPDX-License-Identifier: GPL-3.0-only
set -eu

case $(uname) in
  Linux)
   sudo apt-get update
   sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends cmake
   ;;

  Darwin)
    if [ "$INPUT_CC" = "gcc" ]; then
      INPUT_CC=gcc-10
    fi
    if [ "$INPUT_CXX" = "g++" ]; then
      INPUT_CXX=g++-10
    fi
    ;;

  Windows* | MINGW* | MSYS*)
    choco install cmake --installargs 'ADD_CMAKE_TO_PATH=System'
    ;;

  *)
    echo "Unknown platform: $(uname)"
    exit 1
    ;;
esac
