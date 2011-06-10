Grammar Deployment Kit Reference Manual
Jan Kort
Universiteit Amsterdam
May 2, 2003

http://gdk.sourceforge.net/
http://gdk.sourceforge.net/gdkref.pdf (Chapter 3, page 3)

See also:
	[1] M.G.J. van den Brand, M.P.A. Sellink, and C. Verhoef. Current parsing techniques in software renovation considered harmful. In S. Tilley and G. Visaggio, editors, Proceedings of IWPC’98, pages 108–117, 1998.
	[2] R. L ̈ammel. Grammar Adaptation. In Proceedings of FME’01, volume 2021 of LNCS, pages 550–570. Springer- Verlag, 2001.
	[3] R. L ̈ammel and C. Verhoef. Semi-automatic Grammar Recovery. Software—Practice & Experience, 31(15):1395– 1438, December 2001.

---------------------------------------------------------------------------
The original grammar contained this line:
	disjunction   : {conjunction "|"};

Which is incorrect and thus been replaced by this line:
	disjunction   : {conjunction "|"}+;

                                                          -- Vadim Zaytsev
