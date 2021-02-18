# To try this example
module load accelerator

# Compile the fortran program
mpif77 hello.f -o hello

# To run on the command line
srun --qos=normal --time=10:00 -n 5 ./hello

# Submit the batch job
sbatch submit.sh
