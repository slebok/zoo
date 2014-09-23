http://www.antlr3.org/grammar/list.html
	http://www.antlr3.org/grammar/1200715779785/Python.g

Python 2.5 Grammar
Frank Wierzbicki, Fri Jan 18, 2008 20:09

This grammar is an update to the Python 2.3 grammar in the antlr examples.  It adds the new features from Python 2.5, and also supports more lexing corner cases (for example """foo\"""").  This grammar recognizes all but eight .py files in the Lib directory of release25-maint branch of Python.  The .py files that it cannot match are either deliberately bad files for testing or .py files that use 'as' as an identifier (this will not be allowed in Python 2.5 so I didn't worry about it for now)

Grammar in a broad sense fetched automatically on 23 September 2014 by Vadim Zaytsev, http://grammarware.net
