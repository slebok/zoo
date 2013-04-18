http://relaxng.org/#schemas
 ↳  http://www.thaiopensource.com/relaxng/xhtml/

Modularization of XHTML in RELAX NG

This directory contains an implementataion in RELAX NG of the modularization of XHTML specified by the Modularization of XHTML Recommendation.

The RELAX NG schema has not been mechanically derived from the DTDs. Rather, it has been hand-crafted so as to produce a good quality RELAX NG schema. However, it may well contain bugs.

The modules directory contains all the modules; xhtml-basic.rng uses the modules to implement XHTML Basic; xhtml-strict.rng uses the modules to implement XHTML 1.0 strict; xhtml.rng uses the modules to implement the union of XHTML 1.0 transitional and XHTML 1.0 frameset. You can download everything as part of the main Jing distribution. To create a custom version of XHTML, simply copy xhtml.rng and delete the inclusions of the modules that you do not want.

The biggest difference between the RELAX NG implementation and the DTD implementation is that the RELAX NG implementation does not require you to create a model module specific to the combination of XHTML modules you are using. Instead, simply include the modules you want. The modules take care of redefining the content models appropriately.

Note also the following differences:

The frames module is used instead of the struct module, rather than in addition to it.
In the frames module, the frameset element does not restrict the optional noframes element to follow all the other child elements. XHTML Modularization is inconsistent with both HTML 4.0 and XHTML 1.0 here.
In the basic tables abstract module, the table element does not have a width attribute. The XHTML Rec is ambiguous here: the abstract module has the attribute, but the DTD does not.
The object and applet modules takes advantage of RELAX NG's absence of restrictions on mixed content to enforce the requirement that params precede other content.
The forms module takes advantage of RELAX NG's absence of restrictions on mixed content to enforce the requirement that any legend precedes other content.
The RELAX NG schema does not enforce exclusions. The HTML 4 DTD uses exclusions in several places, for example, to disallow an a element from having an a element as a descendant. It is not possible to represent this constraint in XML DTDs. XHTML Modularization takes the approach of partially representing this restriction by, for example, disallowing an a element from having an a element as a child, without disallowing it from having an a element as a non-immediate descendant. This partial restriction has a substantial cost in increasing the complexity and reducing the modularity of the schemas. This implementation adopts a different approach. The exclude directory contains separate, independent RELAX NG schemas that enforce exclusions. To check use of exclusions, a document should be validated against each of these schemas that is applicable in addition to being validated against the RELAX NG XHTML schema proper. The available schemas are as follows:
exclude/basic.rng
checks the exclusions relating to a and pre elements
exclude/basic-table.rng
checks the exclusions relating to basic tables module (i.e. checks that table elements are not nested)
exclude/form.rng
checks the exclusions relating to forms and basic forms modules
James Clark

Grammars extracted and added to the Grammar Zoo on 18 April 2013 by Vadim Zaytsev.
(Exclusions are abstracted since there is no formal way to specify them on element names - i.e., selectors)
The extraction relies on the RELAX NG grammars downloaded to the 'clark' sibling directory.