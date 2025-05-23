#!/bin/bash
# SPDX-FileCopyrightText: 2008-2025 HPDCS Group <rootsim@googlegroups.com>
# SPDX-License-Identifier: GPL-3.0-only
set -eu

case $(uname) in
  Linux)
   sudo apt-get update
   sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends cmake
   ;;

  Darwin)
    echo "Nothing to install"
    ;;

  Windows* | MINGW* | MSYS*)
    echo "Nothing to install"
    ;;

  *)
    echo "Unknown platform: $(uname)"
    exit 1
    ;;
esac
