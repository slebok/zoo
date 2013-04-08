http://www.emn.fr/z-info/atlanmod/index.php/Ecore#Program_0.1
 ↳  http://gforge.inria.fr/scm/viewvc.php/*checkout*/AtlantEcore/Program.ecore?root=atlantic-zoos

Program 0.1
date : 2007/03/07
Domain : programming
Description :  This metamodel describes programs. A Program inherits both from Structure and ProcContainerElement. A Progam can contain VariableDeclarations (as a Structure), Procedures (as a ProcContainerElement), and Monitors. A Monitor is also a Structure and a ProcContainerElement, and can therefore contain VariableDeclarations and Procedures. Besides Statements and Parameters, a Procedure, as a Structure, can also contain VariableDeclarations. Each VariableDeclaration is associated with a one and only Type. It may also contain an initial value that is represented by an Expression (see below). Parameters inherit from VariableDeclaration. They are characterized by a direction attribute (in or out). A Procedure contains a sequence of Statements. An AssignmentStat contains a target VariableExp and a value Expression. A WhileStat contains a condition Expression and several doStats Statements. A ConditionalStat contains a condition Expression, several thenStats Statements and, optionally, elseStats Statements. Finally, an ExpressionStat simply contains an Expression. Expression is an abstract entity from which the following elements inherit: IntegerExp and BooleanExp (which inherit from the abstract LiteralExp entity), VariableExp which is associated with a VariableDeclaration, PropertyCallExp (abstract) which is characterized by its source element (of type Expression). There exist three types of PropertyCallExp: the AttributeCallExp, the OperatorCallExp and the ProcedureCallExp. An OperatorCallExp contains a right element (of type Expression). A ProcedureCallExp can contain argument Expressions. 
See : 
Authors : Frédéric Jouault

Grammar in a broad sense extracted automatically on 8 April 2013 by Vadim Zaytsev, http://grammarware.net
