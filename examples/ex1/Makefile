# Host building global settings
CXXFLAGS := -I$(XILINX_XRT)/include/ -I$(XILINX_VIVADO)/include/ -Wall -O3 -std=c++11 -L$(XILINX_XRT)/lib/ -lhostsupport -lpthread -lrt -lstdc++
CXXFLAGS2 := -lxilinxopencl

host.cpp: ex1.F90 
	xftn $< --offload -e apply-target{target=u280} -e lower-omp-target-data,omp-target-to-kernel,extract-target,target-to-hls{generate=host} -o host.mlir
	ftn-opt host.mlir -t fpga-host | clang-format > $@

ex1.ll: ex1.F90
	xftn $< --offload -e apply-target{target=u280} -e lower-omp-target-data,omp-target-to-kernel,extract-target,target-to-hls{generate=device},lower-hls -o device.mlir
	../../../amd_fpga/mlir_to_ll.sh device.mlir $@

ex1_v7.xpirbc: ex1.ll
	fxx -k tt_device model.ll ex1_v7 1 tt_device hw 0 0
	/home/nx08/shared/fpga/xilinx/2020.2/Vitis_HLS/2020.2/lnx64/tools/clang-3.9-csynth/bin/llvm-as ex1_v7.ll -o $@

ex1.xo: ex1_v7.xpirbc
	v++ --platform xilinx_u280_xdma_201920_3 -k tt_device -t hw -c $< -o $@

ex1.xclbin: ex1.xo
	v++ --platform xilinx_u280_xdma_201920_3 -t hw -l $< -o $@

build: ex1.xclbin

host_debug.exe: host.cpp
	g++ -DDEBUG $< -o $@ -lOpenCL

host_fpga.exe: host.cpp
	g++ $< -o $@ $(CXXFLAGS) $(CXXFLAGS2)

clean:
	rm -rf host.cpp host.exe *.mlir tmp/ *.ll
