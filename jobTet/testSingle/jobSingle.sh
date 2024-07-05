#!/bin/bash
#
#SBATCH -J singleCore
#SBATCH -t 00:30:00
#SBATCH --mem=2000
#SBATCH -n 1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yuchen.zhou@energy.lth.se
#

#
# load OpenFOAM (of7)
# module load OpenFOAM/7-opt-int32-hpc1-intel-2023a-eb
# source $FOAM_BASHRC

# load OpenFOAM (of10)
module load OpenFOAM/10-opt-int32-hpc1-intel-2023a-eb
source $FOAM_BASHRC
#

#
cp -r $FOAM_TUTORIALS/incompressible/icoFoam/cavity/cavity .
cd cavity
blockMesh >& log.blockMesh
icoFoam >& log.icoFoam
#


