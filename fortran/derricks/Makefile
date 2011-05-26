extract:
	${tooldir}/sdf2bgf ${sdflibdir}/fortran/syntax/*.sdf fortran.sdf.ext.bgf
	${tooldir}/subgrammar fortran.sdf.ext.bgf ExecutableProgram fortran.tmp.bgf
	${tooldir}/xbgf refactor.xbgf fortran.tmp.bgf fortran.sdf.rec.bgf
	cp fortran.sdf.rec.bgf fortran.bgf

include ../../Makefile.include