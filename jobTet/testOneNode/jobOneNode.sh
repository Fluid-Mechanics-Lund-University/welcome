#!/bin/bash
#
#SBATCH -J oneNode
#SBATCH -t 00:30:00
#SBATCH -N 1
#SBATCH --exclusive
#


# load OpenFOAM (of10)
module load OpenFOAM/10-opt-int32-hpc1-intel-2023a-eb
source $FOAM_BASHRC
#

#
cp -r $FOAM_TUTORIALS/incompressible/icoFoam/cavity/cavity .
cd cavity
cp -r $FOAM_TUTORIALS/multiphase/interFoam/laminar/damBreak/damBreak/system/decomposeParDict system
blockMesh
decomposePar -force -fileHandler collated >& log.decomposePar
mpprun -n 4 icoFoam -parallel -fileHandler collated >& log.icoFoam
reconstructPar >& log.reconstructPar
#


