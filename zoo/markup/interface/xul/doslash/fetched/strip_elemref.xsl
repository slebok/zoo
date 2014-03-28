<?xml version="1.0" encoding="UTF-8"?>
<!--
   This XSLT stylesheet is used to strip the XUL Elements Reference found at
   http://www.xulplanet.com/references/elemref/refall_elemref.xml of unneeded 
   information for further processing by xulplanet2schema.xsl into a W3C Schema. 

   Please see http://mozilla.doslash.org/xulschema for more information.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <!-- Root element -->
  <xsl:template match="/elements">
    <elements>
      <xsl:apply-templates select="element"/>
      <xsl:apply-templates select="events"/>
      <xsl:apply-templates select="object[@name='XULElement']"/>
    </elements>
  </xsl:template>
  <!-- ===================== <element> ============================ -->
  <xsl:template match="element">
    <element>
      <xsl:copy-of select="@*|reference|child::reference/following-sibling::text()"/>
      <xsl:apply-templates select="attr"/>
    </element>
  </xsl:template>
  <!-- ============== <object name="XULElement"> ================== -->
  <xsl:template match="object">
    <object name="XULElement">
      <xsl:apply-templates select="attr"/>
    </object>
  </xsl:template>
  <xsl:template match="attr">
    <xsl:choose>
      <xsl:when test="parent::element">
        <!-- For <element>s check if the attribute was already declared on XULElement -->
        <xsl:variable name="name" select="@name"/>
        <xsl:choose>
          <xsl:when
            test="not(//object[@name='XULElement']/attr[@name=current()/@name]) and not(//event[@name=current()/@name])">
            <xsl:copy>
              <xsl:copy-of select="@*"/>
              <xsl:apply-templates/>
            </xsl:copy>
          </xsl:when>
          <xsl:otherwise>
            <xsl:comment> attribute <xsl:value-of select="@name"/> is not copied because it's duplicate </xsl:comment>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <!-- Just copy XULElement's attributes -->
        <xsl:copy>
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- ================= Default action: copy ====================  -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
