http://www.emn.fr/z-info/atlanmod/index.php/Ecore#XML_1.1
 ↳  http://gforge.inria.fr/scm/viewvc.php/*checkout*/AtlantEcore/XML.ecore?root=atlantic-zoos

XML 1.1
date : 2005/06/13
Domain : XML
Description :  This metamodel defines a subset of the Extensible Markup Language (XML). It describes an XML document with one root node. Node is an abstract class having two direct children, namely ElementNode and AttributeNode. ElementNode represents the tags, for example a tag named xml: &lt;xml&gt;&lt;/xml&gt;. ElementNodes can be composed of many Nodes. AttributeNode represents attributes, which can be found in a tag, for example the attr attribute: &lt;xml attr=value of attr/&gt;. ElementNode has two sub classes, namely RootNode and TextNode. RootNode is the root element. The TextNode is a particular node, which does not look like a tag; it is only a string of characters. 
See : 
Authors : Peter Rosendal

Grammar in a broad sense extracted automatically on 8 April 2013 by Vadim Zaytsev, http://grammarware.net
