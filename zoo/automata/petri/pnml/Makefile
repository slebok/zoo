get:
	wget http://www.pnml.org/version-2009/grammar.zip
	unzip grammar.zip
	rm -rf grammar.zip __MACOSX grammar/.svn
	wget http://www.pnml.org/version-2009/extensions/specialarcs.rng -O extensions/specialarcs.rng
	wget http://www.pnml.org/version-2009/extensions/resetptnet.pntd -O extensions/resetptnet.pntd
	wget http://www.pnml.org/version-2009/extensions/inhibitorptnet.pntd -O extensions/inhibitorptnet.pntd
	wget http://www.pnml.org/version-2009/extensions/resetinhibitorptnet.pntd -O extensions/resetinhibitorptnet.pntd

clean:
	rm -rf *.rng *.pntd grammar* __MACOSX

