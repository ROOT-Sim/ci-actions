#!/bin/bash
set -eu

case $(uname) in
    Linux)
       sudo apt-get update
       sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends gcc g++ clang clang++
       ;;

    Darwin)
        brew install gcc
        ;;

    Windows*)
        sdir=$(dirname "${BASH_SOURCE[0]}")
        pwsh "${sdir}\\setup-compilers.ps1"
        ;;

    *)
        echo "Unknown platform:" $(uname)
        exit 1
        ;;
esac
