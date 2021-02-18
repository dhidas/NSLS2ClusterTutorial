# To compile and run this example load the nvhpc module
module load nvhpc

# Compile
nvcc test_cuda.cu -o test_cuda

# Running on the command line
srun --gres=gpu ./test_cuda

