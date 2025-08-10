host.cpp: ex1.F90 
	xftn $< --offload -e apply-target{target=u280} -e lower-omp-target-data,omp-target-to-kernel,extract-target,target-to-hls{generate=host} -o host.mlir
	ftn-opt host.mlir -t fpga-host | clang-format > $@

ex1.ll: ex1.F90
	xftn $< --offload -e apply-target{target=u280} -e lower-omp-target-data,omp-target-to-kernel,extract-target,target-to-hls{generate=device} -o device.mlir
	../../../amd_fpga/mlir_to_ll.sh device.mlir $@

host.exe: host.cpp
	g++ -DDEBUG $< -o $@ -lOpenCL

clean:
	rm -rf host.cpp host.exe *.mlir tmp/ *.ll
