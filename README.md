## Synopsis

Some very basic code snippets to get started with CUDA programming.

## Prerequisites

The CUDA SDK must be installed.  Also, you will need a CUDA capable GPU in your computer (or use a GPU EC2 instance on Amazon Web service).

## Building

As a test of your system sanity, you can build all the demos, and the binaries will be placed in ./bin.
However, they do not do much that is apparent to the naked eye, so the real learning comes from studying 
the code, making changes, rebuilding, etc.  In general, all the scripts can be built like this:

```
nvcc demo1.cu -o bin/demo1 -lcuda
```

## demo1

Allocate and free memory on the device.

## demo2

Copy data to device.

## demo3

Our first kernel: just copy data from one device vector to another.

## demo4

A single threaded (CPU only) version of [matrix multiplication](https://en.wikipedia.org/wiki/Matrix_multiplication).

## demo5 

Multithreaded (GPU) version of matrix multiply.

This is an interesting example because every data element gets visited multiple times, which starts to make the data round trip 
between host and device worth it.

## getprops

A utility program to display the capabilities and resources of your graphics card.  Sample output:

```
DEVICE SPECIFICATIONS:
----------------------
Device name: Quadro M1000M
Total Global Memory: 4238147584
Share mem per block: 49152
Registers per block: 65536
Warp size: 32
Max threads per block: 1024
Max thread dimensions (x, y, z): 1024, 1024, 64
Max grid dimensions (x, y, z): 2147483647, 65535, 65535
Compute capability: 5.0
Multiprocessor count: 4
Cores per multiprocessor (inferred): 128

```
