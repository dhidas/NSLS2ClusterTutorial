This is a basic example of how to use openmp directives to offload to a target GPU.  This offloading
requires a specially compiled compiler which you must first load (name-offload).

# To try these examples
module load accelerator/path
module load gcc/9.3.0-offload

# To compile the GPU offloading code
g++ gpu_test_simple.cc -o gpu_test_simple -fopenmp

# To run this code on the command line
srun --gres=gpu ./gpu_test_simple


The above example will print "Able to use offloading!" if it is working properly.  If not, make sure that you have the proper compiler loaded (see above)


