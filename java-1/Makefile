include ../Makefile.language

get:
	cat ready.lst | xargs -n1 -I _ make _.get

%.get:
	cd $* && make get
