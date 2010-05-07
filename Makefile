build:
	cd c && make build
	cd cpp && make build
	cd csharp && make build

clean:
	cd c && make clean
	cd cpp && make clean
	cd csharp && make clean

test:
	cd c && make test
	cd cpp && make test
	cd csharp && make test
