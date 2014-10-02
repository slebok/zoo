A VERY agile grammar recovery activity.
The sources were given to VVZ by Stijn de Gouw and contained the following:
// Grammar definition for the ABS language
// $Id: ABS.parser 15258 2012-05-04 14:30:36Z fkuehn $
(ABS.parser)
and:
//$Id: ABS.flex 13368 2012-01-16 10:47:25Z pzeller $
(ABS.flex)

Later (4 Feb 2013) the license status was clarified by Richard Bubel and the permission was given to distribute the parser and lexer specs under the modified BSD license.
The files included here in the 'source' directory are the following:
// Grammar definition for the ABS language
// $Id: ABS.parser 18658 2013-02-04 10:44:25Z rbubel $
(ABS.parser)
and:
//$Id: ABS.flex 18658 2013-02-04 10:44:25Z rbubel $
(ABS.flex)

For more information, please refer to the HATS ABS project: http://tools.hats-project.eu/
On metasyntax, refer to Beaver - a LALR Parser Generator: http://beaver.sourceforge.net/spec.html

The final grammar added to the Grammar Zoo on 28 March 2013 by Vadim Zaytsev.
Stijn de Gouw is acknowledged to provide considerable feedback essential for correct extraction of the grammar.
At the current state, the case study is not easily replicable since it involved manual steps
(in terms of SLPS, there is no reliable beaver2bgf grammar extractor).
Still, the grammar is usable and is a precious part of the Grammar Zoo, http://slps.github.com/zoo
