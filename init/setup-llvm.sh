#!/bin/bash
# SPDX-FileCopyrightText: 2008-2025 HPDCS Group <rootsim@googlegroups.com>
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
    pwsh "$(dirname "${BASH_SOURCE[0]}")\\setup-llvm-vscode.ps1"
    ;;

  *)
    echo "Unknown platform: $(uname)"
    exit 1
    ;;
esac
