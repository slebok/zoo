http://www.emn.fr/z-info/atlanmod/index.php/Ecore#BibTeX_1.1
 ↳  http://gforge.inria.fr/scm/viewvc.php/*checkout*/AtlantEcore/BibTeX1.1.ecore?root=atlantic-zoos

BibTeX 1.1
date : 2005/05/17
Domain : bibliography, XML
Description :  This is a partial metamodel of BibTeXML which is an XML-based format for the BibTeX bibliographic tool system for use with LaTeX.  A bibliography is modelized by a BibTeX File element. This element is composed of BibTeX Entries which are each associated with an id. All entries inherit, directly or indirectly, of the abstract BibTeX Entry element. The abstract classes Authored Entry, Dated Entry, Titled Entry and Book Titled Entry, as well as the Misc entry, directly inherit of BibTeX Entry. There are 13 possible entry types: PhD Thesis, Master Thesis, Article, Tech Report, Unpublished, Manual, In Proceedings, Proceedings, Booklet, In Collection, Book, In Book and Misc. Concrete BibTeX entries inherits from some of these abstract classes according to their set of mandatory fields. This metamodel only deals with the mandatory fields of each BibTeX entries (for instance, author, year, title and journal for an article entry). But it has been designed in such a way that it should be easily extensible to handle optional fields (with minor modifications). 
See : <a href="http://bibtexml.sourceforge.net" class="external free" title="http://bibtexml.sourceforge.net" rel="nofollow">http://bibtexml.sourceforge.net</a>
Authors : David Touzet

Grammar in a broad sense extracted automatically on 8 April 2013 by Vadim Zaytsev, http://grammarware.net
