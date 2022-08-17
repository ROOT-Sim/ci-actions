#!/bin/bash
# SPDX-FileCopyrightText: 2008-2021 HPDCS Group <rootsim@googlegroups.com>
# SPDX-License-Identifier: GPL-3.0-only
set -eu

case $(uname) in
  Linux)
   sudo apt install -y -q openmpi-bin libopenmpi-dev
   ;;

  Darwin)
    brew install mpich
    ;;

  Windows* | MINGW* | MSYS*)
    pip install dpcpp-cpp-rt
    pip install impi-devel
    pip install impi_rt
    ;;

  *)
    echo "Unknown platform: $(uname)"
    exit 1
    ;;
esac
