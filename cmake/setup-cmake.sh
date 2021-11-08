#!/bin/bash
set -eu

case $(uname) in
    Linux)
       sudo apt-get update
       sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends cmake
       ;;

    Darwin)
        brew install cmake
        ;;

    Windows*)
        sdir=$(dirname "${BASH_SOURCE[0]}")
        pwsh "${sdir}\\setup-cmake.ps1"
        ;;

    *)
        echo "Unknown platform:" $(uname)
        exit 1
        ;;
esac
