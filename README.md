# NSLS2ClusterTutorial
Cluster tutorial for NSLS-II Cluster

This tutorial contains several examples in subdirectories.  To clone these examples locally:
```
git clone https://github.com/dhidas/NSLS2ClusterTutorial.git
```

## Login
Login to the system requires your BNL credentials, not NSLS-II credentials
```
ssh -Y ssh.nsls2.bnl.gov
ssh -Y pluto
```

## Basics on running slurm jobs

### Simple SLURM Test
If this test does not work you should ask for privileges
```
srun hostname
```

### Important note on Time Limits, QOS, and GPUs
You will almost always need to specify the time you are requesting and the QOS, for example:
```
srun --qos=normal -t 15 hostname  # for 15 minutes using normal qos
```
Just because you have been allocated a gpu* machine does not give you access to the GPU itself.  If you want access to the GPU you must include a --gres=gpu, for example try the following with and without it
```
srun --gres=gpu nvidia-smi
```
Similarly this should be placed in a submit script using (but ONLY if you really need it)
```
#SBATCH --gres=gpu
```

### Useful SLURM Comands
```
sacctmgr show qos     # Show qos information including time limits
squeue                # List what is in the queue
sinfo                 # Print information on cluster
srun                  # Run a SLURM job on the command line
sbatch                # Submit a SLURM batch job
srun --x11 --pty bash # Get a shell on a worker node with x11 forwarding
```

### Job Submission
Typically this is done via a submit.sh file with the command:
```
sbatch submit.sh
```
where for example the submit.sh file might look like:
```
#!/bin/bash
#SBATCH --job-name=test
#SBATCH --error=%x.%J.err
#SBATCH --output=%x.%J.out
#SBATCH --ntasks=10
#SBATCH --qos=normal
#SBATCH --time=10:00

srun [executable or script name here]
```

### SLURM QOS and Time Limits
The default qos is 'normal' and default time limit is very small.  You should always specify the time you want.  On the command line this is, for example:
```
srun --qos=long -t 0-13:00:00 ./myexe  # for 13 hours
```
and in a submit script this would be
```
#SBATCH --qos=long
#SBATCH --time=0-13:00:00
```

### Debug
The QOS for debug is higher priority, but has limited available CPU and a very short time limit.  To use this, for example:
```
srun --qos=debug -n 3 hostname
```


## Software
Software is configured using environment modules. You can view what is available with
```
module avail
```
The following will make available many standard options for all cluster users
```
module load spack
```
A suite of accelerator codes, offloading compilers, and software can be found (and used by anyone)
```
module load accelerator/path
```
Conda is available
```
module load anaconda3
```

### Accelerator Software
To load *all* of the default accelerator software
```
module load accelerator
```
or to choose individually first load
```
module load accelerator/path
```
