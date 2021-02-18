#include <iostream>
#include <omp.h>


int main (int argc, char* argv[])
{
  int T[1] = {-1};
  #pragma omp target
  {
    T[0] = omp_is_initial_device();
  }

  if (!T[0]) {
    printf("Able to use offloading!\n");
  } else {
    printf("offloading is not working properly.  Check you are using --gres=gpu in the srun or sbatch command\n");
  }

  return 0;
}
