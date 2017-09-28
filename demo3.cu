// demo 3: push some data to device
// a first kernel
// compile with:
// nvcc demo3.cu -lcuda -o demo3
#include <iostream>
#include <string>
#include <typeinfo>
#include <cuda.h>
#include <cuda_runtime_api.h>
#include <stdio.h>

using namespace std;
#include "safecalls.h"

__global__ void mykernel(int ncol, int nrow, int* input, int* output)
{
  int idx = blockIdx.x * blockDim.x + threadIdx.x;
  int idy = blockIdx.y * blockDim.y + threadIdx.y;
  int index = idx + idy * ncol;
  if(index < ncol * nrow) {
    output[index] = input[index]; 	
  }
}

int main()
{
    dim3 dimBlock(4, 4); 
    dim3 dimGrid(1, 1); 
    size_t size = sizeof(int) * 16;
	int* in = (int*)malloc(size);
	int* out = (int*)malloc(size);
	CUdeviceptr ind;
	CUdeviceptr outd;
	int i;

    // initalize input and output 'matrices'
	for(i = 0; i < 16; i++) {
      in[i] = i;
	}

    cout << "Contents of out before kernel call:\n";
	for(i = 0; i < 16; i++) {
      cout << out[i] << " ";
	}
    cout << "\n\n";

	cudaThreadSynchronize(); 

	cuMemAlloc(&ind, size);
	cuMemAlloc(&outd, size);
	cuMemcpyHtoD(outd, out, size);
	cuMemcpyHtoD(ind, in, size);
	mykernel <<<dimGrid, dimBlock>>>(4, 4, (int*)ind, (int*)outd);
	cuMemcpyDtoH(out, outd, size);


    cout << "Contents of out after  kernel call:\n";
	for(i = 0; i < 16; i++) {
      cout << out[i] << " ";
	}
    cout << "\n";

	cuMemFree(ind);
	cuMemFree(outd);
	return 0;
}

