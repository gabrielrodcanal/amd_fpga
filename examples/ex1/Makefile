host.cpp: ex1.F90 
	xftn $< --offload -e apply-target{target=u280} -e lower-omp-target-data,omp-target-to-kernel,extract-target,target-to-hls{generate=host}
	ftn-opt ex1_offload.mlir -t fpga-host | clang-format > $@

host.exe: host.cpp
	g++ -DDEBUG $< -o $@ -lOpenCL

clean:
	rm -rf host.cpp host.exe *.mlir tmp/
