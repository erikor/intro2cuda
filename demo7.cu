#include <iostream>
#include <stdlib.h>
#include <string>
#include <cuda.h>
#include <stdio.h>
#include <time.h>
#include "safecalls.h"

using namespace std;

#define N 1000

__global__ void matrixShared (int *a, int *b, int width) {
    __shared__ int s[100 * sizeof(int)];
    int tx = threadIdx.x;
    int ty = threadIdx.y;
    int value;
	int col = threadIdx.x + blockDim.x * blockIdx.y;
	int row = threadIdx.y + blockDim.y * blockIdx.y;
    int i;

    s[tx + ty * blockDim.x] = a[col + row * width];	

    __syncthreads();
    
    for(i=0; i<1000; i++) {
       value = s[tx + ty * blockDim.x] + i;
    }
    a[col + row * width] = value;	
}

int main() {
	int i, j;
	int* a;
	int* b;
	srand(time(NULL)); 

	CUdeviceptr ad, bd;
	int size = N * N * sizeof(int);

	dim3 dimGrid(100, 100);
	dim3 dimBlock(10, 10);

    a = (int*)malloc(size);
    b = (int*)malloc(size);

    for(i=0; i<N; i++) {
    	for(j=0; j<N; j++) {
    		a[i+j*N] = rand();
    	}
    }

	// print out a bit of data to show starting values
	for(i = 0; i<10; i++) {
		printf("%d\n", b[i]);
	}	


	CUDA_SAFE_CALL(cuMemAlloc(&ad, size));
	CUDA_SAFE_CALL(cuMemAlloc(&bd, size));
	CUDA_SAFE_CALL(cuMemcpyHtoD(ad, a, size));

	matrixShared<<<dimGrid, dimBlock>>>((int*)ad, (int*)bd, N);

	CUDA_SAFE_CALL(cuMemcpyDtoH(b, bd, size));
	cuMemFree(ad); 	cuMemFree(bd);

	// print out a bit of data to show we did something
	for(i = 0; i<10; i++) {
		printf("%d\n", b[i]);
	}	
	return 0;

}

