#!/usr/bin/env bash
#
# You should only work under the /scratch/users/<username> directory.
#
# Example job submission script
#
# -= Resources =-
#
#SBATCH --job-name=sudoku-jobs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --partition=shorter
#SBATCH --qos=shorter
#SBATCH --time=01:00:00
#SBATCH --output=run.out
#SBATCH --mem-per-cpu=1G
#SBATCH --gres=gpu:1
################################################################################
##################### !!! DO NOT EDIT ABOVE THIS LINE !!! ######################
################################################################################
# Set stack size to unlimited
echo "Setting stack size to unlimited..."
ulimit -s unlimited
ulimit -l unlimited
ulimit -a

# echo "Loading GCC 11..."
# module load gcc/11.2.0
module load gcc/9.3.0
module load cuda/11.8.0

echo

echo "Running Job...!"
echo "==============================================================================="
echo "Running compiled binary..."
rm mcubes
nvcc main.cu -o mcubes -lcudart
cd out

../mcubes -o

