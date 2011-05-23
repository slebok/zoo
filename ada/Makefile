build:
	cd kempe && make build
	cd kellogg && make build
	cd laemmel-verhoef && make build
	cd lncs-2219 && make build
	cd lncs-4348 && make build

clean:
	cd kempe && make clean
	cd kellogg && make clean
	cd laemmel-verhoef && make clean
	cd lncs-2219 && make clean
	cd lncs-4348 && make clean

test:
	cd kempe && make test
	cd kellogg && make test
	cd laemmel-verhoef && make test
	cd lncs-2219 && make test
	cd lncs-4348 && make test

diff:
	cp kempe/ada.bgf kempe.bgf
	cp laemmel-verhoef/ada.bgf laemmel-verhoef.bgf
	cp lncs-2219/ada.bgf lncs-2219.bgf
	cp lncs-4348/ada.bgf lncs-4348.bgf
	make build
	../../../shared/tools/gdts kempe/ada.bgf kempe.bgf || exit -1
	../../../shared/tools/gdts laemmel-verhoef/ada.bgf laemmel-verhoef.bgf || exit -1
	../../../shared/tools/gdts lncs-2219/ada.bgf lncs-2219.bgf || exit -1
	../../../shared/tools/gdts lncs-4348/ada.bgf lncs-4348.bgf || exit -1
