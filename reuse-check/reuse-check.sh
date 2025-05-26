#!/bin/bash
# SPDX-FileCopyrightText: 2008-2025 HPDCS Group <rootsim@googlegroups.com>
# SPDX-License-Identifier: GPL-3.0-only
set -eu

case $(uname) in
  Linux)
    pip install reuse
    reuse lint
    ;;

  Darwin | Windows* | MINGW* | MSYS*)
    echo "This action is expected to run only in Linux"
    ;;

  *)
    echo "Unknown platform: $(uname)"
    exit 1
    ;;
esac
