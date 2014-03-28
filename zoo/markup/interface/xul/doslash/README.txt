http://mozilla.doslash.org/xulschema/

About

This is an informal schema for XUL, it isn't normative in any way. The intention is to create a schema which can be used in XUL or generic XML editors to provide elements/attributes autocompletion and document validation.

The schema is written in W3C XML Schema language. The schema and XSLTs were tested using an evaluation version of <oXygen/> XML Editor.

This is work in progress. The schema is not complete and is incorrect in certain places. However it should be useful enough in its current state. If you find an error, please contact me (see below).

The schema is meant to be a bit restrictive in what it allows. While Gecko often accepts very weird input, like "<window xmlns="http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul"> <tab><button><button/></button></tab> </window>", it doesn't make sense to allow that in most XUL documents.

The schema aims to represent XUL as used in Mozilla Firefox 1.0 and other Toolkit applications. XPFE dialect, currently used by Mozilla Suite 1.7 is slightly different and is not what the schema describes. The schema doesn't include new elements introduced in later toolkit versions.

Generating the schema

Because of licensing problems the full schema has to be generated from several XML files - the downloadable version doesn't contain the documentation from XUL Planet.

Detailed descriptions for generating the full schema were moved to a separate page.

Licensing and copyrights

Various files used here are created by different people and are subject to different restrictions.

All XSLT files in the package are (C) 2005, Nickolay Ponomarev, and are subject to Mozilla Public License.
The xulstructure.xml / xulstructure.xsd files are based on a reworked version of XUL Schema by Franklin de Graaf, which is (C) 2003 X-Power Computing Group Inc. Franklin generously allowed me to base these files on his schema, and they are also available under MPL.
The refall_elemref.xml file (XUL Elements Reference) is (C) Neil Deakin and cannot be redistributed without author's permission. It can be freely downloaded from xulplanet.com though.
This means the schema cannot be freely redistributed as well, as it includes large chunks of the XUL Elements Reference.

To-do

Figure out what's missing (XUL templates-related elements and new Firefox 1.5 elements, at least).
Fix the comments marked "XXX" in various files in the package.
Check the schema accuracy, fix the errors (as the current version is more like a proof of concept)
Get rid of the custom XML format used, switch to RNG.



Fetched on 28 March 2014 by Vadim Zaytsev, http://grammarware.net
