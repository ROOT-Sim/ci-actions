#!/bin/bash
set -eu

case $(uname) in
  Linux)
   sudo apt install -y -q openmpi-bin libopenmpi-dev
   ;;

  Darwin)
    brew install mpich
    ;;

  Windows* | MINGW*)
    sdir=$(dirname "${BASH_SOURCE[0]}")
    pwsh "${sdir}\\setup-mpi.ps1"
    ;;

  *)
    echo "Unknown platform:" $(uname)
    exit 1
    ;;
esac
