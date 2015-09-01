extract:
	cat fetched/index.html | grep -v '<TD><CENTER><SMALL><A HREF=#ddef:comments>' > noseps.prepared.txt

fetch:
	wget http://www.cs.vu.nl/grammarware/browsable/os-pli-v2r3/
	mv index.html fetched/

# include ../../../Makefile.grammar