# To try this example
module load accelerator

# To run on the command line
srun --qos=normal --time=10:00 -n 5 Pelegant fma1p.ele

# Or to submit it
sbatch submit.sh
