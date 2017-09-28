// single threaded matrix multiply
// nvcc demo4.cu -o demo4
// time ./demo4

#include <stdio.h>

#define N 800

void matrixMult (int* a, int* b, int* c, int width)
{
	for (int i = 0; i < width; i++) {
		for (int j = 0; j < width; j++) {
			int sum = 0;
			for (int k = 0; k < width; k++) {
				int m = a[i + k * width];
				int n = b[k * width + j];
				sum += m * n;
			}
			c[i + width * j] = sum;
		}
	}
}

int main() {
	int i, j;
	int* a;
	int* b;
	int* c;
	long size = N * N * sizeof(int);
    a = (int*)malloc(size);
    b = (int*)malloc(size);
    c = (int*)malloc(size);

/*    for(i=0; i<N; i++) {
    	for(j=0; j<N; j++) {
    		a[i+j*N] = 2;
    		b[i+j*N] = 2;
    		c[i+j*N] = 2;
    	}
    }
*/
	matrixMult(a, b, c, N);
}
