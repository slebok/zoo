http://www.antlr.org/
	https://github.com/antlr
		https://github.com/antlr/grammars-v4/
			https://github.com/antlr/grammars-v4/tree/master/tnsnames

-------------------------------------------------------------------
Definition of a grammar to parse a tnsnames.ora file.
Specification as per Oracle 11g Release 2 Network Reference manual
http://docs.oracle.com/cd/E11882_01/network.112/e10835/tnsnames.htm
-------------------------------------------------------------------
Norman Dunbar.
August 2014.
-------------------------------------------------------------------
Warning: I'm not a compiler writer, nor do I play one on TV.
Warning: This is my first "proper" ANTLR grammar.
-------------------------------------------------------------------
This grammar assumes, that we are dealing with tnsnames entries that 
locate a database, or, those that describe a listener or scan 
listener.
-------------------------------------------------------------------
MAYBE TODO:

PROTOCOL_STACK??? - I've never seen this in the wild! Only on
http://www.toadworld.com/platforms/oracle/w/wiki/5484.defining-tnsname-addresses.aspx

Add IP V6 lever rule. Currently only copes with IP V4.
-------------------------------------------------------------------


-------------------------------------------------------------------
The MIT License (MIT) 

Copyright (c) 2014 by Norman Dunbar 

Permission is hereby granted, free of charge, to any person 
obtaining a copy of this software and associated documentation 
files (the "Software"), to deal in the Software without 
restriction, including without limitation the rights to use, 
copy, modify, merge, publish, distribute, sublicense, and/or sell 
copies of the Software, and to permit persons to whom the 
Software is furnished to do so, subject to the following 
conditions: 

The above copyright notice and this permission notice shall be 
included in all copies or substantial portions of the Software. 

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR 
OTHER DEALINGS IN THE SOFTWARE. 

Project      : Oracle Tnsnames.ora parser grammer for ANTLR4.
Developed by : Norman Dunbar
-------------------------------------------------------------------


Grammar in a broad sense fetched automatically on 12 October 2014 by Vadim Zaytsev, http://grammarware.net
