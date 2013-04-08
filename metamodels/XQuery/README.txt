http://www.emn.fr/z-info/atlanmod/index.php/Ecore#XQuery_1.1
 ↳  http://gforge.inria.fr/scm/viewvc.php/*checkout*/AtlantEcore/XQuery.ecore?root=atlantic-zoos

XQuery 1.1
date : 2005/06/13
Domain : XML
Description :  This metamodel describes a query language called XQuery, which is designed to be broadly applicable across many types of XML data sources. It contains also parts of the XML metamodel (Node, ElementNode, AttributeNode and TextNode). An XQueryProgram is composed of ExecutableExpressions which can be FLWOR expressions, function calls (FunctionCall) and function declarations (FunctionDeclaration). The main class is FLWOR, it represents FLWOR expressions which are composed of For, Let, Where, Order by and Return statements. For is composed of an XPath expression representing the value stored by the variable defined by the var attribute. Let is also composed of an XPath expression representing the value stored by the variable defined by the var attribute. Where is composed of a boolean XPath expression used to do a selection on the variables of the For statements. OrderBy is composed of an XPath expression defining how to order the output. Return is composed of Expressions representing the output data. Expression is the superclass of ExecutableExpressions, (XML-) Nodes and ReturnXPath expressions. The Node class and its sub classes are the same as those of the XML metamodel. There are two different XPath classes. In the ReturnXPath class the corresponding String expression (value) has to be put between braces, in the XPath class the expression is without braces. 
See : www.w3.org/TR/xquery/
Authors : Peter Rosendal

Grammar in a broad sense extracted automatically on 8 April 2013 by Vadim Zaytsev, http://grammarware.net
