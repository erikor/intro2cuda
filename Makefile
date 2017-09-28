all: demo1 demo2 demo3 demo4 demo5

demo1: demo1.cu
	nvcc -o bin/demo1 demo1.cu -lcuda

demo2: demo2.cu
	nvcc -o bin/demo2 demo2.cu -lcuda

demo3: demo3.cu
	nvcc -o bin/demo3 demo3.cu -lcuda

demo4: demo4.cu
	nvcc -o bin/demo4 demo1.cu -lcuda

demo5: demo5.cu
	nvcc -o demo5 demo5.cu -lcuda