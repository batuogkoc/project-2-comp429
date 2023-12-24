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
#SBATCH --output=exp1.out
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
echo "Compiling..."
rm mcubes
nvcc main.cu -o mcubes -lcudart
# cd out
DIR="exp1"
echo "Running compiled binary..."
# for THREAD_NUM in 1 4 16 32 64 128 256 512 1024
# do
#     ./mcubes -n 128 -f 1 -b 1 -t ${THREAD_NUM} | tee "${DIR}/mcubes-n128-f1-b1-t${THREAD_NUM}.txt"
#     ./mcubes -n 32 -f 64 -b 1 -t ${THREAD_NUM} | tee "${DIR}/mcubes-n32-f64-b1-t${THREAD_NUM}.txt"
#     ./mcubes -n 4 -f 32768 -b 1 -t ${THREAD_NUM} | tee "${DIR}/mcubes-n4-f32768-b1-t${THREAD_NUM}.txt"
# done

DIR="exp2"
for BLOCK_NUM in 1 10 20 40 80 160
do
    ./mcubes -n 128 -f 1 -b ${BLOCK_NUM} -t 1024 | tee "${DIR}/mcubes-n128-f1-b${BLOCK_NUM}-t1024.txt"
    ./mcubes -n 4 -f 32768 -b ${BLOCK_NUM} -t 1024 | tee "${DIR}/mcubes-n4-f32768-b${BLOCK_NUM}-t1024.txt"
done

