
#!/bin/bash

# This generates a file every 5 minutes

while true; do
  srun -n 150 ./hello
done
