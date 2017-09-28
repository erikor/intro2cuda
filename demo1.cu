// demo 1: allocate and free device memory

// a note about headers:
// https://devtalk.nvidia.com/default/topic/1002219/does-nvcc-include-header-files-automatically-/

// build:
// nvcc demo1.cu -o demo1

#include <stdio.h>
 
int main()
{
	char *mymem;
	cudaMalloc( (void**)&mymem, 1);
	cudaFree(mymem);
	printf("Success!\n");
	return 0;
}