http://relaxng.org/#schemas
  ↳  http://www.jenitennison.com/schema/xmlschema.rng

RELAX NG schema for XML Schema by Jeni Tennison. Based on 
  <doc:link href="http://www.w3.org/TR/2001/REC-xmlschema-1-20010502/">XML 
  Schema Part I: Structures Recommendation</doc:link> and <doc:link 
  href="http://www.w3.org/TR/2001/REC-xmlschema-2-20010502/">XML Schema Part 
  II: Datatypes</doc:link>.

<doc:changes date="2001-11-24">
  <doc:p>
    Amended to comply with 10 August 2001 Tutorial.
  </doc:p>
  <doc:change>Removed key attributes.</doc:change>
  <doc:change>Replaced not element with except elements.</doc:change>
  <doc:change>
    Replaced multiple consecutive optional attributes to use the 
    zeroOrMore/choice pattern.
  </doc:change>
  <doc:change>
    Removed interleave elements inside list elements (which are no longer 
    permitted).
  </doc:change>
</doc:changes>
<doc:changes date="2004-10-12">
  <doc:p>Amended to comply with final version of RNG.</doc:p>
  <doc:change>Changed to avoid conflicting ID types.</doc:change>
</doc:changes>
	
Grammar extracted and added to the Grammar Zoo on 19 April 2013 by Vadim Zaytsev.
