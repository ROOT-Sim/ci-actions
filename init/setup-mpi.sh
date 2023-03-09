#!/bin/bash
# SPDX-FileCopyrightText: 2008-2021 HPDCS Group <rootsim@googlegroups.com>
# SPDX-License-Identifier: GPL-3.0-only
set -eu

case $(uname) in
  Linux)
   sudo apt install -y -q openmpi-bin libopenmpi-dev
   ;;

  Darwin)
    brew install mpich
    ;;

  Windows* | MINGW* | MSYS*)
    installer_name=w_mpi_oneapi_p_2021.8.0.25543_offline.exe
    base_url=https://registrationcenter-download.intel.com/akdlm/irc_nas/19160
    curl -sO $base_url/$installer_name
    ./$installer_name -s -a --silent --eula accept
    ONEAPI_ROOT="C:\Program Files (x86)\Intel\oneAPI"
    I_MPI_ROOT="${ONEAPI_ROOT}\mpi\latest"
    echo "ONEAPI_ROOT=${ONEAPI_ROOT}" >> $GITHUB_ENV
    echo "I_MPI_ROOT=${I_MPI_ROOT}" >> $GITHUB_ENV
    echo "${I_MPI_ROOT}\bin" >> $GITHUB_PATH
    echo "${I_MPI_ROOT}\bin\release" >> $GITHUB_PATH
    echo "${I_MPI_ROOT}\libfabric\bin" >> $GITHUB_PATH
    echo "${I_MPI_ROOT}\libfabric\bin\utils" >> $GITHUB_PATH

    ONEAPI_ROOT="/c/Program Files (x86)/Intel/oneAPI"
    I_MPI_ROOT="${ONEAPI_ROOT}/mpi/latest"
    export PATH="${I_MPI_ROOT}/bin:$PATH"
    export PATH="${I_MPI_ROOT}/bin/release:$PATH"
    export PATH="${I_MPI_ROOT}/bin/libfabric/bin:$PATH"

    hydra_service.exe -install
    ;;

  *)
    echo "Unknown platform: $(uname)"
    exit 1
    ;;
esac
