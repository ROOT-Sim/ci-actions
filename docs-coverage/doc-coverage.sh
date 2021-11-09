#!/bin/bash
set -eu

case $(uname) in
  Linux | Darwin | Windows* | MINGW* | MSYS*)
    pip install coverxygen
    cd build
    $GITHUB_ACTION_PATH/doc_coverage.py
    ;;

  *)
    echo "Unknown platform:" $(uname)
    exit 1
    ;;
esac
