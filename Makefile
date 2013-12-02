all:

include Makefile.language

test:
	ls -1 */*/*.bgf | xargs -n1 ../slps/shared/tools/validate bgf

