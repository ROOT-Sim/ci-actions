#!/bin/bash
# SPDX-FileCopyrightText: 2008-2021 HPDCS Group <rootsim@googlegroups.com>
# SPDX-License-Identifier: GPL-3.0-only
set -eu

if test "x$WITHMPI" = 'xno'; then
  exit 0
fi

case $(uname) in
  Linux)
   sudo apt install -y -q openmpi-bin libopenmpi-dev
   ;;

  Darwin)
    brew install mpich
    ;;

  Windows* | MINGW* | MSYS*)
    url=https://registrationcenter-download.intel.com/akdlm/IRC_NAS/c11b9bf0-2527-4925-950d-186dba31fb40
    package=w_mpi_oneapi_p_2021.9.0.43421_offline.exe
    curl -sO $url/$package
    ./$package -s -a --silent --eula accept

    ONEAPI_ROOT="C:\Program Files (x86)\Intel\oneAPI"
    I_MPI_ROOT="${ONEAPI_ROOT}\mpi\latest"
    library_kind="release"
    I_MPI_OFI_LIBRARY_INTERNAL="1"

    echo "ONEAPI_ROOT=${ONEAPI_ROOT}" >> $GITHUB_ENV
    echo "I_MPI_ROOT=${I_MPI_ROOT}" >> $GITHUB_ENV
    echo "library_kind=${library_kind}" >> $GITHUB_ENV
    echo "I_MPI_OFI_LIBRARY_INTERNAL=${I_MPI_OFI_LIBRARY_INTERNAL}" >> $GITHUB_ENV

    echo "${I_MPI_ROOT}\\bin" >> $GITHUB_PATH
    echo "${I_MPI_ROOT}\\bin\\$library_kind" >> $GITHUB_PATH
    echo "${I_MPI_ROOT}\\libfabric\\bin" >> $GITHUB_PATH
    echo "${I_MPI_ROOT}\\libfabric\\bin\\utils" >> $GITHUB_PATH

    ONEAPI_ROOT="/c/Program Files (x86)/Intel/oneAPI"
    I_MPI_ROOT="${ONEAPI_ROOT}/mpi/latest"
    export PATH="${I_MPI_ROOT}/bin:$PATH"
    export PATH="${I_MPI_ROOT}/bin/$library_kind:$PATH"

    hydra_service.exe -install
    ;;

  *)
    echo "Unknown platform: $(uname)"
    exit 1
    ;;
esac
