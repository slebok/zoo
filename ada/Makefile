extract:
	cd kempe && make extract
	cd kellogg && make extract
	cd laemmel-verhoef && make extract
	cd lncs-2219 && make extract
	cd lncs-4348 && make extract

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
	make extract
	../../../shared/tools/gdts kempe/ada.bgf kempe.bgf || exit -1
	../../../shared/tools/gdts laemmel-verhoef/ada.bgf laemmel-verhoef.bgf || exit -1
	../../../shared/tools/gdts lncs-2219/ada.bgf lncs-2219.bgf || exit -1
	../../../shared/tools/gdts lncs-4348/ada.bgf lncs-4348.bgf || exit -1
	cp kempe/ada.bgf kempe.bgf
	cp laemmel-verhoef/ada.bgf laemmel-verhoef.bgf
	cp lncs-2219/ada.bgf lncs-2219.bgf
	cp lncs-4348/ada.bgf lncs-4348.bgf
