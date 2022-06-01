# NSLS2ClusterTutorial
Cluster tutorial for NSLS-II Cluster

Several basic examples can be found at https://github.com/dhidas/NSLS2ClusterTutorial/.  To clone these examples locally:
```
git clone https://github.com/dhidas/NSLS2ClusterTutorial.git
```

## Login
Login to the system requires your BNL credentials (+DUO Federal)
```
ssh -X ssh.nsls2.bnl.gov    # directs you to ssh1,2,3,4 gateways
ssh -X pluto                # directs you to submit1,2
```
More detailed instructions can be found at https://www-dev.nsls2.bnl.gov/docs/remote/ssh.html (internal BNL)

## Home and Data Directories
Home directories have a quota of about 100 GB:
```
/nsls2/users/[USER]
```
with backup snapshots at: ```/nsls2/users/.snapshot/*/[USER]```

For data storage:
```
/nsls2/data/staff/[USER]
```

## Jupyter
A jupyterhub exists and is accessible from outside as well as inside BNL:
https://jupyter.nsls2.bnl.gov

Once logged in, select the "Scientific Python (accelerator)" which will give the environment equivalent to "module load accelerator".  12 hours idle will end your session.

You can open a terminal in jupyter, but you cannot submit slurm jobs from it.  You can however "ssh -t ssh.nsls2 ssh pluto" from it and then submit jobs from the submit node.

## Copying files from other NSLS-II machines
Use a "JumpHost" with the -J option in scp:
```
scp -J ssh.nsls2.bnl.gov localfile username@pluto:remotefile
```
or user jupyter to upload and download files (drag into jupyter navigator):
https://jupyter.nsls2.bnl.gov

## Help
Get help on the Cluster Teams discussion:
https://teams.microsoft.com/l/channel/19%3ad6ec59ad69f24ee197fb0f82aa989979%40thread.skype/Cluster?groupId=0ae37900-a0ad-4249-bcce-456329a3bb2b&tenantId=89561e60-dc75-4c28-a1c9-2e8d8870196b


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
There is a dedicated partition for debugging which you can use (add --gres=gpu if you need the gpu)
```
srun -p debug -n 3 hostname
```
There is also QOS for debug on the usual nodes with higher priority, but has limited available CPU and a very short time limit.  To use this, for example:
```
srun --qos=debug -n 3 hostname
```



### Accelerator Software
Software is configured using environment modules.  To load *all* of the default accelerator software
```
module load accelerator
```
or to choose individually first load
```
module load accelerator/path
```
You can view what is available with (accelerator software is only seen after loading at minimum 'accelerator/path')
```
module avail
```
#### PyElegant
To load pyelegant
```
module load accelerator pyelegant
```



## GPU Usage and Programming
### GPU Access
To access the GPUs on the cluster you must include the --gres=gpu flag

### GPU Programming
If you wish to write code for GPUs there are several ways.  The first is to write cuda directly and use the nvidia hpc tools for compilation which you can load and checn the version with
```
module load nvhpc
nvcc --version
```
Another way is to use openmp target offloading.  There are two special compilers available for this available via
```
module load accelerator
module swap gcc/9.3.0-offload   # This is the default (and will work well with other packages under accelerator/path
```
An alternative if one needs it is
```
module unload gcc
module load gcc/10.2.0-offload
```

### Compilers
Many versions of the gnu compilers are available.  In addition to this you will also find llvm which provides clang and flang (this is was os x uses as 'gcc').  nvhpc provides nvcc.  The intel compiler is not currently provided.


## Other Software
Conda is available
```
module load anaconda3
```
