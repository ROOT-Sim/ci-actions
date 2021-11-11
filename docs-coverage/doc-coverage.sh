#!/bin/bash
# SPDX-FileCopyrightText: 2008-2021 HPDCS Group <rootsim@googlegroups.com>
# SPDX-License-Identifier: GPL-3.0-only
set -eu

case $(uname) in
  Linux)
    pip install coverxygen
    if [ "$EVENT" = "pull_request" ]; then
      $GITHUB_ACTION_PATH/doc_coverage.py -s . -b build/$INPUT_BUILD_PATH -t $INPUT_THRESHOLD -g
    else
      $GITHUB_ACTION_PATH/doc_coverage.py -s . -b build/$INPUT_BUILD_PATH -t $INPUT_THRESHOLD
    fi
    ;;

  Darwin | Windows* | MINGW* | MSYS*)
    echo "This action is expected to run only in Linux"
    ;;

  *)
    echo "Unknown platform:" $(uname)
    exit 1
    ;;
esac
