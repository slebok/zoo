all:

build:
	cd ada && make build
	cd c && make build
	cd cpp && make build
	cd csharp && make build
	cd fortran && make build
	cd java && make build
	cd modula && make build

extract:
	cd ada && make extract
	cd c && make extract
	cd cpp && make extract
	cd csharp && make extract
	cd fortran && make extract
	cd java && make extract
	cd modula && make extract

test:
	cd ada && make test
	cd c && make test
	cd cpp && make test
	cd csharp && make test
	cd fortran && make test
	cd java && make test
	cd modula && make test

clean:
	cd ada && make clean
	cd c && make clean
	cd cpp && make clean
	cd csharp && make clean
	cd fortran && make clean
	cd java && make clean
	cd modula && make clean
