// demo 2: push some data to device

// compile with:
// nvcc demo2.cu -lcuda -o demo2

#include <stdio.h>
#include <cuda.h>

int main()
{
	int a[4] = {1,2,3,4};
    size_t size = sizeof(int) * 4;
	CUdeviceptr ad;
	cuMemAlloc( &ad, size);
    cuMemcpyHtoD(ad, a, size);
	cuMemFree(ad);
	printf("Success!\n");
	return 0;
}