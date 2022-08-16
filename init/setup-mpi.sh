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
    mpi_url="https://registrationcenter-download.intel.com/akdlm/irc_nas/18715/w_mpi_oneapi_p_2021.6.0.546_offline.exe"
    curl -o intel_installer.exe $mpi_url
    ./intel_installer.exe --silent -a --silent --action=install --eula=accept
    rm ./intel_installer.exe
    ;;

  *)
    echo "Unknown platform: $(uname)"
    exit 1
    ;;
esac
