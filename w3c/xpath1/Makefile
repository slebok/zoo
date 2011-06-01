extract:
	${tooldir}/spec2bgf src.recommendation.xml ext.bgf
	${tooldir}/xbgf normalize.xbgf ext.bgf grammar.bgf
	#${tooldir}/subgrammar xpath.ext.2.bgf Expr xpath.bgf

steps:
	/usr/local/bin/xsltproc ../../extraction/w3c/spec2bgf.xslt xpath1.xml > xpath.v1.bgf
	cp xpath.v1.bgf xpath.v2.bgf
	perl -pi -w -e 's/<unknown>\)\*<\/unknown>/<unknown>\)<\/unknown><postfix-star\/>/g;' xpath.v2.bgf
	perl -pi -w -e 's/<unknown>\)\?<\/unknown>/<unknown>\)<\/unknown><postfix-optional\/>/g;' xpath.v2.bgf
	perl -pi -w -e 's/<unknown>\?\)\?<\/unknown>/<postfix-optional\/><unknown>\)<\/unknown><postfix-optional\/>/g;' xpath.v2.bgf
	perl -pi -w -e "s/<unknown>\(\'.\'<\/unknown>/<unknown>\(<\/unknown><terminal>.<\/terminal>/g;" xpath.v2.bgf
	perl -pi -w -e 's/<unknown>\(<\/unknown>/<sequence><bgf:expression>/g;' xpath.v2.bgf
	perl -pi -w -e 's/<unknown>\)<\/unknown>/<\/bgf:expression><\/sequence>/g;' xpath.v2.bgf
	/usr/local/bin/xsltproc ../../extraction/w3c/postfix2confix.xslt xpath.v2.bgf > xpath.v3.bgf
	/usr/local/bin/xsltproc ../../extraction/w3c/cleanup.xslt xpath.v3.bgf > xpath.v4.bgf
	${tooldir}/validate bgf xpath.v4.bgf
	${tooldir}/xbgf xpath1.normalize.xbgf xpath.v4.bgf xpath.v5.bgf
	${tooldir}/subgrammar xpath.v5.bgf Expr xpath.v6.bgf
	${tooldir}/bgf2html xpath.v6.bgf xpath.html

include ../../Makefile.grammar