C#
Language Specification
Version 3.0

Copyright © Microsoft Corporation 1999-2007. All Rights Reserved.
Please send corrections, comments,  and other feedback to sharp@microsoft.com

Notice
© 1999-2007 Microsoft Corporation. All rights reserved.
Microsoft, Windows, Visual Basic, Visual C#, and Visual C++ are either registered trademarks or trademarks of Microsoft Corporation in the U.S.A. and/or other countries/regions.
Other product and company names mentioned herein may be the trademarks of their respective owners.

Errors spotted right away:
	page 200, §7.14; page 480, §B.2.4,
		explicit-anonymous-function-parameter-list
	instead of
		explicit-anonymous-function-parameter-list:
	and
		implicit-anonymous-function-parameter-list
	instead of
		implicit-anonymous-function-parameter-list:
	(changed manually in msft-ls-1.0-annex.txt)

	page 73, §3.8; page 473, §B.2.1,
		namespace-or-type-name   .   identifier   type-argument-listop
	instead of
		namespace-or-type-name   .   identifier   type-argument-listopt
	(changed manually in msft-ls-1.0-annex.txt)

	page 468, §B.1.7
		the definition of keyword lacks:
			group by join on equals into let get set yield partial var orderby
			add remove where from select ascending descending alias field method
			param property assembly module
	(added manually to keywords.lst)
