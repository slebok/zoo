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
	make kempe.diff
	make kellogg.diff
	make laemmel-verhoef.diff
	make lncs-2219.diff
	make lncs-4348.diff

%.diff:
	cd $* && make extract
	../../../shared/tools/gdts $*/ada.bgf $*.bgf || exit -1