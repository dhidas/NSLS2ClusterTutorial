#!/bin/bash

#SBATCH --job-name=hello
#SBATCH --error=%x.%J.err 
#SBATCH --output=%x.%J.out
#SBATCH --ntasks=5
#SBATCH --time=10:00
#SBATCH --qos=normal

srun ./hello
