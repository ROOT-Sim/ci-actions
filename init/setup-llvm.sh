#!/bin/bash
# SPDX-FileCopyrightText: 2008-2021 HPDCS Group <rootsim@googlegroups.com>
# SPDX-License-Identifier: GPL-3.0-only
set -eu

case $(uname) in
  Linux)
   sudo apt install -y -q llvm
   ;;

  Darwin)
    brew install llvm
    ;;

  Windows* | MINGW* | MSYS*)
    ;;

  *)
    echo "Unknown platform: $(uname)"
    exit 1
    ;;
esac
