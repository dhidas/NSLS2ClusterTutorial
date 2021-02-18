# To run this example try:

module load accelerator

# Then to run on the command line
srun --qos=normal --time=10:00 -n 5 python hello.py

# or to submit it using sbatch:
sbatch submit.sh
