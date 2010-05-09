C# Language Specification
Standard ECMA-334
1st Edition
December 2001

http://www.ecma-international.org/publications/files/ECMA-ST-WITHDRAWN/ECMA-334,%201st%20edition,%20December%202001.pdf

Errors spotted right away:

	page 341:
		the definition of keyword lacks:
			assembly remove get set field method module param property add volatile
	(added manually to keywords.lst)

	page 347:
		the definition of primary-no-array-creation-expression contains sizeof-expression,
		which should be a part of §A.3 Grammarextensionsforunsafecode
	(manually removed from ecma-334-annex.txt)
	(spotted because {sizeof-expression} was L-split into {"sizeof" "-" expression})