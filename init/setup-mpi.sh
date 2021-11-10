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
    sdir=$(dirname "${BASH_SOURCE[0]}")
    pwsh "${sdir}\\setup-mpi.ps1"
    ;;

  *)
    echo "Unknown platform:" $(uname)
    exit 1
    ;;
esac
