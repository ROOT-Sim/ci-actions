#!/bin/bash
set -eu

case $(uname) in
    Linux)
       sudo apt install -y -q openmpi-bin libopenmpi-dev
       ;;

    Darwin)
        brew install mpich
        ;;

    Windows*)
        sdir=$(dirname "${BASH_SOURCE[0]}")
        pwsh "${sdir}\\setup-mpi.ps1"
        ;;

    *)
        echo "Unknown platform:" $(uname)
        exit 1
        ;;
esac

#if [ $MPI == openmpi ]; then
#    openmpi_mca_params=$HOME/.openmpi/mca-params.conf
#    mkdir -p $(dirname $openmpi_mca_params)
#    echo plm=isolated >> $openmpi_mca_params
#    echo rmaps_base_oversubscribe=true >> $openmpi_mca_params
#    echo btl_base_warn_component_unused=false >> $openmpi_mca_params
#    echo btl_vader_single_copy_mechanism=none >> $openmpi_mca_params
#    if [[ $(uname) == Darwin ]]; then
#        # open-init/ompi#7516
#        echo gds=hash >> $openmpi_mca_params
#        # open-init/ompi#5798
#        echo btl_vader_backing_directory=/tmp >> $openmpi_mca_params
#    fi
#fi
