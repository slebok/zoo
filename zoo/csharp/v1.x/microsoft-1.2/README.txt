C#
Language Specification
Version 1.2

http://download.microsoft.com/download/5/e/5/5e58be0a-b02b-41ac-a4a3-7a22286214ff/csharp%20language%20specification%20v1.2.doc

Copyright © Microsoft Corporation 1999-2003. All Rights Reserved.
Please send corrections, comments,  and other feedback to csharp@microsoft.com

Notice
© 1999-2003 Microsoft Corporation. All rights reserved.
Microsoft, Windows, Visual Basic, Visual C#, and Visual C++ are either registered trademarks or trademarks of Microsoft Corporation in the U.S.A. and/or other countries/regions.
Other product and company names mentioned herein may be the trademarks of their respective owners.

Errors spotted right away:
	page 358, §B.1.7
		the definition of keyword lacks:
			group by join on equals into let get set yield partial var orderby
			add remove where from select ascending descending alias field
			method param property dynamic assembly module
	(added manually to keywords.lst)

	page 380, §B.2.13
		[   global-attribute-target-specifier   attribute-list   ,]
	instead of
		[   global-attribute-target-specifier   attribute-list   , ]
	(changed manually in msft-ls-annex.txt)