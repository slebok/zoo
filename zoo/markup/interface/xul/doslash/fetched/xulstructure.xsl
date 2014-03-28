<?xml version="1.0" encoding="UTF-8"?>
<!--
   This XSLT stylesheet is used to transform structure information in 
   xulstructure.xml into a W3C Schema definitions. Please see 
   http://mozilla.doslash.org/xulschema for more information.
-->

<xsl:stylesheet xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <!--  -->
  <xsl:template match="/elements">
    <xs:schema xmlns:xul="http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul"
      targetNamespace="http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul">
      <xsl:apply-templates/>
    </xs:schema>
  </xsl:template>
  <!--  -->
  <xsl:template match="type">
    <xsl:apply-templates>
      <xsl:with-param name="type" select="concat(@name,'ElementType')"/>
    </xsl:apply-templates>
  </xsl:template>
  <!--  -->
  <xsl:template match="element[@name]">
    <xsl:param name="type"/>
    <xs:complexType name="{@name}ElementType">
      <xs:complexContent>
        <xs:extension base="xul:{$type}">
          <xsl:apply-templates/>
        </xs:extension>
      </xs:complexContent>
    </xs:complexType>
  </xsl:template>
  <xsl:template match="group[@name]">
    <xs:group name="{@name}ElementGroup">
      <xsl:apply-templates/>
    </xs:group>
  </xsl:template>
  <!-- ElementType definitions -->
  <xsl:template match="definetype">
    <xs:complexType name="{@name}ElementType">
      <xsl:choose>
        <xsl:when test="@derive">
          <xs:complexContent>
            <xs:extension base="xul:{@derive}ElementType">
              <xsl:apply-templates/>
            </xs:extension>
          </xs:complexContent>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </xs:complexType>
  </xsl:template>
  <xsl:template match="defineelement">
    <xs:element name="{@name}"/>
  </xsl:template>
  <!--  -->
  <xsl:template match="element[@ref]">
    <xs:element ref="xul:{@ref}">
      <xsl:copy-of select="@minOccurs|@maxOccurs"/>
    </xs:element>
  </xsl:template>
  <xsl:template match="group[@ref]">
    <xs:group ref="xul:{@ref}ElementGroup">
      <xsl:copy-of select="@minOccurs|@maxOccurs"/>
    </xs:group>
  </xsl:template>
  <xsl:template match="attributeGroup[@ref]">
    <xs:attributeGroup ref="xul:{@ref}AttributeGroup"/>
  </xsl:template>
  <!-- rng -> schema -->
  <xsl:template match="zeroOrMore">
    <xs:choice minOccurs="0" maxOccurs="unbounded">
      <xsl:apply-templates/>
    </xs:choice>
  </xsl:template>
  <xsl:template match="oneOrMore">
    <xs:choice maxOccurs="unbounded">
      <xsl:apply-templates/>
    </xs:choice>
  </xsl:template>
  <!--  -->
  <xsl:template match="choice">
    <xs:choice>
      <xsl:copy-of select="@minOccurs|@maxOccurs"/>
      <xsl:apply-templates/>
    </xs:choice>
  </xsl:template>
  <xsl:template match="sequence">
    <xs:sequence>
      <xsl:copy-of select="@minOccurs|@maxOccurs"/>
      <xsl:apply-templates/>
    </xs:sequence>
  </xsl:template>
  <xsl:template match="all">
    <xs:all>
      <xsl:apply-templates/>
    </xs:all>
  </xsl:template>
  <xsl:template match="any">
    <xs:any>
      <xsl:copy-of select="@*"/>
    </xs:any>
  </xsl:template>
  <xsl:template match="optional">
    <xs:sequence minOccurs="0" maxOccurs="1">
      <xsl:apply-templates/>
    </xs:sequence>
  </xsl:template>
</xsl:stylesheet>
