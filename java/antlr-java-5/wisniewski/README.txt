http://www.antlr.org/grammar/list:
 ↳  http://www.antlr.org/grammar/1109874324096/java1.5.zip

Updated Java 1.5 Grammar
Scott Wisniewski Thu Mar 3, 2005 10:25
Contains modifications to the Michael Studman's Java 1.5 gramamr to provider better conformance to the Java Language Specification. In particular it includes the following enhancements:

1. Regonozies full range of Java Identifiers
2. Provides full support for unicode escape processing

Unicode escape processing is provided via the means of the attached pre processor that provides full unicode escape processing. Java allows unicode escape sequences to appear at any point in the input, not just inside of strings. The preprocessor is written in C#, and provides a TextReader implementation that scans an existing TextReader and replaces unicode escape sequences with the appropriate unicode character.

It is essentally a hand written DFA. However, it uses coroutines (for my sanity), so in order to build it you will need version 2.0 of the .NET Framework (or Visual Studio 2005), which is currently still in beta. Hopefully its easy to port if you need to use it with other langauges.
