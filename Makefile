MKDIR_P := mkdir -p
OUT_DIR := bin

all: directories demo1 demo2 demo3 demo4 demo5 getprops

directories: $(OUT_DIR)

$(OUT_DIR):
	${MKDIR_P} $(OUT_DIR)


demo1: demo1.cu
	nvcc -o bin/demo1 demo1.cu -lcuda

demo2: demo2.cu
	nvcc -o bin/demo2 demo2.cu -lcuda

demo3: demo3.cu
	nvcc -o bin/demo3 demo3.cu -lcuda

demo4: demo4.cu
	nvcc -o bin/demo4 demo4.cu -lcuda

demo5: demo5.cu
	nvcc -o bin/demo5 demo5.cu -lcuda

getprops: getprops.cu
	nvcc -o bin/getprops getprops.cu -lcuda
