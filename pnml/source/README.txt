http://www.pnml.org/:
 ↳  http://www.pnml.org/version-2009/version-2009.php
   ↳  http://www.pnml.org/version-2009/grammar.zip
   ↳  http://www.pnml.org/version-2009/extensions/specialarcs.rng
   ↳  http://www.pnml.org/version-2009/extensions/resetptnet.pntd
   ↳  http://www.pnml.org/version-2009/extensions/inhibitorptnet.pntd
   ↳  http://www.pnml.org/version-2009/extensions/resetinhibitorptnet.pntd

PNML grammar, version 2009

The earliest (non standardized) version of PNML was 1.3.2. It does not support the now required concept of Page in PNML models. It
does not support the family of High-level Petri Nets ( Symmetric Nets and High-level Petri Net Graphs).

Version 2009 is the current active version of PNML grammar. You may download the entire grammar in one archive.

It defines the following concepts:

• The definition of PNML Core Model.
• Labels used by PT Nets nodes and arcs.
• The any element construct used to define any grammar the standard does not provide precise definition for; for instance, tool specific definition.
• PT Nets type declaration.
• Booleans
• Finite enumerations
• Cyclic enumerations
• Finite integer ranges
• Dots
• Multisets
• Partitions
• Lists
• Integers
• Strings
• Terms
• Arbitrary declarations
• High-level Core Structure
• High-level Place/Transition Nets: they are defined as a restriction of High-level Petri Nets Graphs
• Symmetric Nets
• High-Level Nets

Extensions

It is possible to extend PNML schema in any way suitable to your specific need. However, as we said on the presentation page, your
new defined type will not yet be standard-compatible. This situation will last until part 3 of the standard defines a coherent
theoretical and practical framework to do so, in order for standard-compliant tools to automatically discover and read without any
ambiguities, Petri net models according to your new type.

As an example, we publish here Jan Martijn's definition of three new P/T net types:

• reset;
• inhibitor;
• and reset-inhibitor nets.

These PNTDs use a convention document, declaring the special arcs needed for their definition.

For more information please refer to http://www.pnml.org/ and contact the authors of these grammars and definitions, for which they
retain full rights in whatever degree they desire.
