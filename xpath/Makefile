test:
	../../../shared/tools/spec2bgf xpath1.xml xpath.bgf
	../../../shared/tools/validate bgf xpath.bgf
	../../../shared/tools/xbgf xpath1.normalize.xbgf xpath.bgf xpath.fixed.bgf
	../../../shared/tools/bgf2html xpath.fixed.bgf xpath.html

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
	../../../shared/tools/validate bgf xpath.v4.bgf
	../../../shared/tools/xbgf xpath1.normalize.xbgf xpath.v4.bgf xpath.v5.bgf
	../../../shared/tools/bgf2html xpath.v5.bgf xpath.html

get:
	curl -k http://www.w3.org/TR/1999/REC-xpath-19991116.xml >xpath1.xml
	curl -k http://www.w3.org/TR/2007/REC-xpath20-20070123/xpath20.xml >xpath2.xml
	curl -k http://www.w3.org/XML/1998/06/xmlspec-v20.dtd > xmlspec-v20.dtd
	perl -pi -w -e 's/\/XML\/1998\/06\/xmlspec-v20.dtd/xmlspec-v20.dtd/g;' xpath1.xml
	
clean:
	rm -f *~ *.bgf
