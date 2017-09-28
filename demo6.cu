#include <iostream>
#include <stdlib.h>
#include <string>
#include <stdio.h>
#include <time.h>

#define N 1000

int main() {
	int i, j, n, value;
	int* a;
	int* b;
	srand(time(NULL));   // should only be called once
	int size = N * N * sizeof(int);

    a = (int*)malloc(size);
    b = (int*)malloc(size);

	// print out a bit of data to show starting values
	for(i = 0; i<10; i++) {
		printf("%d\n", b[i]);
	}	


    for(i=0; i<N; i++) {
    	for(j=0; j<N; j++) {
    		a[i+j*N] = rand();
    		//a[i+j*N] = 2;
    	}
    }
    for(i=0; i<N; i++) {
    	for(j=0; j<N; j++) {
    		for(n=0; n<1000; n++) {
		       value = a[i + j * N] + i;
    		}
    		b[i+j*N] = value;
    	}
    }

	// print out a bit of data to show we did something
	for(i = 0; i<10; i++) {
		printf("%d\n", b[i]);
	}	

	free(a);
	free(b);
	
	return 0;

}

