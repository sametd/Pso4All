FC=gfortran
F90FLAGS= -O3 -march=native -Wall

main.x: config.o types.o mersenne_twister.o objective.o pso.o main.o
	$(FC) $(F90FLAGS) -o main.x config.o mersenne_twister.o \
	types.o objective.o pso.o main.o

test: main.x
	bash -c "time ./main.x test.xyz"

config.o : config.f90
	$(FC) -c $(F90FLAGS) config.f90

types.o : types.f90
	$(FC) -c $(F90FLAGS) types.f90

mersenne_twister.o : mersenne_twister.f90
	$(FC) -c $(F90FLAGS) mersenne_twister.f90

objective.o : objective.f90
	$(FC) -c $(F90FLAGS) objective.f90

pso.o : pso.f90
	$(FC) -c $(F90FLAGS) pso.f90

main.o : main.f90
	$(FC) -c $(F90FLAGS) main.f90

clean:
	rm -f main.x *.o *.mod
