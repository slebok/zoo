http://www.mediawiki.org/wiki/Markup_spec/BNF
{{Grammar nav}}
This is an attempt to describe the MediaWiki markup in [[w:Backus-Naur form|Backus-Naur form]]. This is not strictly possible, for at least the following two reasons:
#The logic for parsing combinations of bold, italics and apostrophes
#The logic for parsing nested lists.

Therefore, this grammar will necessarily be incomplete. Where it is incomplete, strategies to parse the non-EBNF parts of the grammar will be described.

The primary goal is to define the MediaWiki parser ''as it currently works''. However, in certain cases, such as where truly bizarre syntax is technically tolerated, the grammar may be restricted to a more useful subset. For example, the following code:

 <nowiki>#REDireCTnon%^sense[[foo|and this is parsed as article content</nowiki>

is technically a valid way to write a redirect, but is neither useful nor likely to be in current use. Such deviations from the actual implemented grammar will be noted as they occur.

== About the definitions ==
The definitions are in [[w:Backus-Naur form|Backus-Naur form]] for the moment.  We may find the need to use the extended form (EBNF) to stop things getting too complicated (though it should be noted that EBNF expressions can ''always'' be written as BNF).

In general, when parsing a page using this grammar, the matching should be a top-down non-greedy match.  i.e. it will always try earlier rules before later ones (always starting from a single point; <wiki-page> in the case of wiki pages) but take the minimum characters to satisfy the complete rule.  Exceptions to this should be noted (and avoided if possible).

Bear in mind that these are translation rules, which will be used to convert from one format to another (e.g. wiki-text to HTML), so the grammar may need to include elements that are technically redundant so that they can be referenced in the conversion rules.

All terminals (literal strings) are '''case-insensitive''' unless mentioned otherwise.

== The basics ==
These pages describe basic elements that are used throughout the description, and which are fairly generic.

* [[/Fundamental elements/]]

== Wiki pages ==
This is the basic high-level structure of a wiki-page.  Follow the links for the details.  This section is incredibly incomplete at the moment.

* [[/Article#Wiki-page|<wiki-page>]] constitutes the '''start symbol''' (a.k.a. "top-level element") describing the wiki page,
** [[/Article#Wiki-page|<redirect>]]
** [[/Article#Article|<article>]]
*** [[/Links/]]
*** [[/Magic links/]] (e.g. RFC, ISBN, etc.)
*** [[/Nowiki|&lt;nowiki&gt;]]

== Other data formats ==
The following types of data are external to the wiki page (e.g. the Article's title).

* [[/Article title/]]

[[Category:Parser| BNF]]