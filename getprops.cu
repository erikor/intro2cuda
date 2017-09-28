// retrieve device capabilities
// nvcc demo4.cu -o demo4
// time ./demo4c 

#include <iostream>
#include <string>
#include <typeinfo>
#include <cuda.h>

using namespace std;

/*
 *  Infer number of cores per multiprocessor from compute capability
 *  Based on Robert Crovella's SO response: https://goo.gl/XguKMK
 *  Also see https://people.maths.ox.ac.uk/gilesm/cuda/prac1/helper_cuda.h
 */
int getSPcores(cudaDeviceProp devProp)
{  
  int cores = 0;
  switch (devProp.major){
  case 2: // Fermi
    if (devProp.minor == 1) cores = 48;
    else cores = 32;
    break;
  case 3: // Kepler
    cores = 192;
    break;
  case 5: // Maxwell
    cores = 128;
    break;
  case 6: // Pascal
    if (devProp.minor == 1) cores = 128;
    else if (devProp.minor == 0) cores = 64;
    else cores = -999;
    break;
  default:
    cores = -999;
  break;
  }
  return cores;
}

int main() {
  cudaDeviceProp props;
  cudaGetDeviceProperties(&props, 0);
  cout << "DEVICE SPECIFICATIONS:" << endl << "----------------------" << endl;
  cout << "Device name: " << props.name << endl;
  cout << "Total Global Memory: " << props.totalGlobalMem << endl;
  cout << "Share mem per block: " << props.sharedMemPerBlock << endl;
  cout << "Registers per block: " << props.regsPerBlock << endl;
  cout << "Warp size: " << props.warpSize << endl;
  cout << "Max threads per block: " << props.maxThreadsPerBlock << endl;
  cout << "Max thread dimensions (x, y, z): " << props.maxThreadsDim[0] << ", "
       << props.maxThreadsDim[1] << ", "
       << props.maxThreadsDim[2] << endl;
  cout << "Max grid dimensions (x, y, z): " << props.maxGridSize[0] << ", "
       << props.maxGridSize[1] << ", "
       << props.maxGridSize[2] << endl;
  cout << "Compute capability: " << props.major << "." << props.minor << endl;
  cout << "Multiprocessor count: " << props.multiProcessorCount << endl;
  cout << "Cores per multiprocessor (inferred): " << getSPcores(props) << endl;
  return 0;
}