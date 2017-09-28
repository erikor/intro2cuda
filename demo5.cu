#include <stdio.h>
#include <cuda.h>

#define N 1000

__global__ void matrixMult (int *a, int *b, int *c, int width) {
	int k, sum = 0;
	long col = threadIdx.x + blockDim.x * blockIdx.x;
	long row = threadIdx.y + blockDim.y * blockIdx.y;
	if(col < width && row < width) {
		for (k = 0; k < width; k++)
			sum += a[row * width + k] * b[k * width + col];
		c[row * width + col] = sum;
	}
}

int main() {
	int i, j;
	int* a;
	int* b;
	int* c;
	CUdeviceptr ad, bd, cd;
	long size = N * N * sizeof(int);
	dim3 dimGrid(100, 100);
	dim3 dimBlock(100, 100);

    a = (int*)malloc(size);
    b = (int*)malloc(size);
    c = (int*)malloc(size);

    for(i=0; i<N; i++) {
    	for(j=0; j<N; j++) {
    		a[i+j*N] = 2;
    		b[i+j*N] = 2;
    		c[i+j*N] = 2;
    	}
    }

    cudaThreadSynchronize(); 

	cuMemAlloc(&ad, size);
	cuMemAlloc(&bd, size);
	cuMemAlloc(&cd, size);
	cuMemcpyHtoD(ad, a, size);
	cuMemcpyHtoD(bd, b, size);
	cuMemcpyHtoD(cd, c, size);

    cudaThreadSynchronize(); 

	//matrixMult <<<dimGrid, dimBlock>>>((int*)ad, (int*)bd, (int*)cd, N);

	//cuMemcpyDtoH(c, cd, size);
	cuMemFree(ad); 	cuMemFree(bd); 	cuMemFree(cd);

}

