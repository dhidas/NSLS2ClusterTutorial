#include <iostream>

int main (int argc, char* argv[])
{
  int ngpu = 0;
  cudaGetDeviceCount(&ngpu);

  if (ngpu <= 0) {
    std::cerr << "ERROR: no GPUs are available" << std::endl;
    return 1;
  }

  cudaDeviceProp prop;

  for (int i = 0; i != ngpu; ++i) {
    cudaGetDeviceProperties(&prop, i);
    std::cout << "GPU " << i << std::endl;
    std::cout << "  Device name: " << prop.name << std::endl;
    std::cout << "  Memory Clock Rate (KHz): " << prop.memoryClockRate << std::endl;
    std::cout << "  Memory Bus Width (bits): " << prop.memoryBusWidth << std::endl;
    std::cout << "  Peak Memory Bandwidth (GB/s): " << 2.0*prop.memoryClockRate*(prop.memoryBusWidth/8)/1.0e6 << std::endl;
    std::cout << std::endl;
  }

  return 0;
}
