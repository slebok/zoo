http://www.antlr.org/grammar/list:
 ↳  http://replay.waybackmachine.org/20070221211202/http://www.credmp.org/index.php/antlr-java-syntax/
    ↳  http://replay.waybackmachine.org/20070125214025/http://credmp.org/files/java.g

Java 1.5 (for C++)
Arjen 'credmp' Wiersma Mon Oct 2, 2006 00:37
This is the mashup of the existing Java 1.5 syntaxes for ANTLR 2.7.x. It has both generics and annotations.

This is the full Java 1.5 (Generics and Annotations included) syntax for ANTLR 2.7.x which will generate C++ code. The versions on the ANTLR website and grammar index all generate Java code.

Using this syntax file allows you to create a Parser and Lexer for the Java language in C++.

The syntax was released in public domain, so I re-release my version in the public domain as well.

Please note, in this version (as found by Keffin) parameritized parameters and variable length parameters (TRIPLE_DOT) are broken. I am in the process of migrating to Antrl v3, so expect a new updated version soon where I will fix these errors. Hopefully I will have time to update the current syntax to parse the parameters correctly so it is usable.
