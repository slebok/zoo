<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   This is an XSLT stylesheet converting the stripped down (by strip_elemref.xsl)
   XUL Elements Reference to a W3C Schema.

   Please see http://mozilla.doslash.org/xulschema for more information.
-->

<!-- attrs with type=xs:int should be manually processed -->
<xsl:stylesheet xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xul="http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <!-- ==================================================== -->
  <!-- Common XUL events. Cannot generate in stylesheet itself due to XSLT limitations -->
  <xsl:param name="output"/>
  <xsl:variable name="ignore_attr"
    select="' grippyhidden onblur onbroadcast onchange onclick onclose oncommand oncommandupdate oncontextmenu     ondblclick ondragdrop ondragenter ondragexit ondraggesture ondragover onfocus oninput onkeydown onkeypress onkeyup onload onmousedown onmousemove onmouseout onmouseover onmouseup onoverflow onoverflowchanged onpopuphidden onpopuphiding onpopupshowing onpopupshown onselect onunderflow onunload '"/>
  <xsl:variable name="ignore_elts"
    select="' textbox (Firefox Auto Complete) textbox (Mozilla Auto Complete) grippy toolbargrippy '"/>
  <!-- ==================================================== -->
  <xsl:template match="/">
    <!-- XXX legal disclaimer - waiting for an answer from Neil -->
    <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema"
      xmlns:xul="http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul"
      targetNamespace="http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul">
      <xsl:comment>======================================================================</xsl:comment>
      <xsl:comment>===== DO NOT EDIT! THIS IS A GENERATED FILE ==========================</xsl:comment>
      <xsl:comment>======================================================================</xsl:comment>
      <xsl:comment> Generated from the XUL Planet's Elements Reference. 
                   See http://mozilla.doslash.org/xulschema for more info </xsl:comment>
      <xsl:comment>======================================================================</xsl:comment>
      <!--====  Common XUL attributes and events ===================================-->
      <xsl:if test="$output='common' or $output=''">
        <xsl:comment> This file defines common XUL attributes and events </xsl:comment>
        <xsl:comment> 
    ...but let's declare a few simple types first:
  </xsl:comment>
        <xsl:comment> boolType is used instead of xs:boolean to make XML editors show true/false dropdown </xsl:comment>
        <xs:simpleType name="boolType">
          <xs:restriction base="xs:string">
            <xs:enumeration value="true"/>
            <xs:enumeration value="false"/>
          </xs:restriction>
        </xs:simpleType>
        <xsl:comment> scriptType is for inline script code, that often occurs in on* attributes </xsl:comment>
        <xs:simpleType name="scriptType">
          <xs:restriction base="xs:string"/>
        </xs:simpleType>
        <xsl:comment> 
    Common (i.e. not specific to a few) XUL attributes. These are all sticked into XULElement attributes
    on XulPlanet.com, we are more restrictive about this. While certain combinations allowed by the schema
    may not make sense, it's still better than allowing all of XULElement attributes on all XUL elements.
            
    There are a few groups of attributes declared below. 
      IdAttributeGroup     (used solely for overlayElementType)
      CommonAttributeGroup (also includes IdAttributeGroup)
      XULAttributeGroup = CommonAttributeGroup + OverlayAttributeGroup + RDFAttributeGroup 
      BoxAttributeGroup
      ContainerAttributeGroup
      EventHandlerAttributeGroup
    The last three don't include any attributeGroups, so generally a XUL element includes one to four 
    of the following attribute groups: XULAttributeGroup, BoxAttributeGroup, ContainerAttributeGroup.             
  </xsl:comment>
        <xsl:variable name="e" select="//object[@name='XULElement']/attr"/>
        <xsl:comment>
     Attributes that make sense for *all* XUL elements - that is, to info elements too
   </xsl:comment>
        <xs:attributeGroup name="IdAttributeGroup">
          <xsl:apply-templates select="$e[@name='id']"/>
          <xsl:apply-templates select="$e[@name='class']"/>
        </xs:attributeGroup>
        <xs:attributeGroup name="CommonAttributeGroup">
          <xs:attributeGroup ref="xul:IdAttributeGroup"/>
          <xsl:apply-templates select="$e[@name='observes']"/>
          <xsl:apply-templates select="$e[@name='ordinal']"/>
          <xsl:apply-templates select="$e[@name='persist']"/>
        </xs:attributeGroup>
        <xsl:comment> 
     And these make sense for any element in an overlay 
   </xsl:comment>
        <xs:attributeGroup name="OverlayAttributeGroup">
          <xsl:apply-templates select="$e[@name='insertafter']"/>
          <xsl:apply-templates select="$e[@name='insertbefore']"/>
          <xsl:apply-templates select="$e[@name='position']"/>
          <xsl:apply-templates select="$e[@name='removeelement']"/>
        </xs:attributeGroup>
        <xsl:comment> 
     Attributes used with XUL templates (xxx TBD) 
   </xsl:comment>
        <xs:attributeGroup name="RDFAttributeGroup">
          <xsl:apply-templates select="$e[@name='allownegativeassertions']"/>
          <xsl:apply-templates select="$e[@name='coalesceduplicatearcs']"/>
          <xsl:apply-templates select="$e[@name='container']"/>
          <xsl:apply-templates select="$e[@name='containment']"/>
          <xsl:apply-templates select="$e[@name='datasources']"/>
          <xsl:apply-templates select="$e[@name='empty']"/>
          <xsl:apply-templates select="$e[@name='flags']"/>
          <xsl:apply-templates select="$e[@name='ref']"/>
          <xsl:apply-templates select="$e[@name='sortDirection']"/>
          <xsl:apply-templates select="$e[@name='sortResource']"/>
          <xsl:apply-templates select="$e[@name='sortResource2']"/>
          <xsl:apply-templates select="$e[@name='template']"/>
          <xsl:apply-templates select="$e[@name='uri']"/>
        </xs:attributeGroup>
        <xsl:comment> 
      This group combines all of the above. These attributes apply to almost all XUL elements
    </xsl:comment>
        <xs:attributeGroup name="XULAttributeGroup">
          <!-- xxx bad name -->
          <xs:attributeGroup ref="xul:CommonAttributeGroup"/>
          <xs:attributeGroup ref="xul:OverlayAttributeGroup"/>
          <!-- don't include rdf attributes - at least for now  xs:attributeGroup ref="xul:RDFAttributeGroup"/-->
        </xs:attributeGroup>
        <xsl:comment> 
      These make sense for any visible element 
    </xsl:comment>
        <xs:attributeGroup name="BoxAttributeGroup">
          <xsl:apply-templates select="$e[@name='collapsed']"/>
          <xsl:apply-templates select="$e[@name='hidden']"/>
          <xsl:apply-templates select="$e[@name='flex']"/>
          <xsl:apply-templates select="$e[@name='context']"/>
          <xsl:apply-templates select="$e[@name='contextmenu']"/>
          <xsl:apply-templates select="$e[@name='menu']"/>
          <xsl:apply-templates select="$e[@name='popup']"/>
          <xsl:apply-templates select="$e[@name='tooltip']"/>
          <xsl:apply-templates select="$e[@name='tooltiptext']"/>
          <xsl:apply-templates select="$e[@name='debug']"/>
          <xsl:apply-templates select="$e[@name='statustext']"/>
          <xsl:apply-templates select="$e[@name='style']"/>
          <xsl:apply-templates select="$e[@name='wait-cursor']"/>
          <!-- xxx Some/most/all of these only apply to elements in stack -->
          <xsl:apply-templates select="$e[@name='top']"/>
          <xsl:apply-templates select="$e[@name='left']"/>
          <xsl:apply-templates select="$e[@name='height']"/>
          <xsl:apply-templates select="$e[@name='maxheight']"/>
          <xsl:apply-templates select="$e[@name='maxwidth']"/>
          <xsl:apply-templates select="$e[@name='minheight']"/>
          <xsl:apply-templates select="$e[@name='minwidth']"/>
          <xsl:apply-templates select="$e[@name='width']"/>
        </xs:attributeGroup>
        <xsl:comment> 
      These Attributes affect the children of the element, therefore 
      they only apply to container elements 
    </xsl:comment>
        <xs:attributeGroup name="ContainerAttributeGroup">
          <xsl:apply-templates select="$e[@name='align']"/>
          <xsl:apply-templates select="$e[@name='allowevents']"/>
          <xsl:apply-templates select="$e[@name='dir']"/>
          <xsl:apply-templates select="$e[@name='equalsize']"/>
          <xsl:apply-templates select="$e[@name='mousethrough']"/>
          <xsl:apply-templates select="$e[@name='orient']"/>
          <xsl:apply-templates select="$e[@name='pack']"/>
        </xs:attributeGroup>
        <xsl:comment> 
      Common XUL events
    </xsl:comment>
        <xs:attributeGroup name="EventHandlerAttributeGroup">
          <xsl:apply-templates select="//events/event"/>
        </xs:attributeGroup>
      </xsl:if>
      <!--====  XUL elements ========================================================-->
      <xsl:if test="$output='elements' or $output=''">
        <xsl:comment> This file contains the list of XUL elements with descriptions </xsl:comment>
        <xsl:if test="$output='elements'">
          <xs:include schemaLocation="xulcommon.xsd"/>
        </xsl:if>
        <xsl:apply-templates
          select="//element[not(boolean(@lang='xbl') or substring-before(@name,':')='rdf')]"/>
      </xsl:if>
    </xs:schema>
  </xsl:template>
  <!-- ==================================================== -->
  <xsl:template match="element">
    <!-- xxx autocomplete -->
    <xsl:if test="not(contains($ignore_elts,concat(' ',@name,' '))) or @name='textbox'">
      <xsl:variable name="name" select="@name"/>
      <xs:element name="{@name}">
        <xs:annotation>
          <xs:documentation>
            <xsl:value-of select="child::reference/following-sibling::text()"/>
          </xs:documentation>
        </xs:annotation>
        <xs:complexType>
          <xs:complexContent>
            <xs:extension base="xul:{$name}ElementType">
              <xsl:apply-templates select="attr"/>
            </xs:extension>
          </xs:complexContent>
        </xs:complexType>
      </xs:element>
    </xsl:if>
  </xsl:template>
  <!-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= -->
  <xsl:template name="annotateAttrs">
    <xs:annotation>
      <xs:documentation>
        <xsl:value-of select="child::text()"/>
      </xs:documentation>
    </xs:annotation>
  </xsl:template>
  <xsl:template match="attr">
    <!-- Note: this throws away elaborate explanations of some events -->
    <xsl:if test="not(contains($ignore_attr,concat(' ',@name,' ')))">
      <xs:attribute>
        <xsl:attribute name="name">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
        <!-- set up type -->
        <xsl:choose>
          <xsl:when test="@type='boolean'">
            <xsl:if test="count(value)=0">
              <xsl:attribute name="type">xul:boolType</xsl:attribute>
              <xsl:call-template name="annotateAttrs"/>
            </xsl:if>
          </xsl:when>
          <xsl:when test="@type='integer'">
            <xsl:attribute name="type">xs:int</xsl:attribute>
            <xsl:call-template name="annotateAttrs"/>
          </xsl:when>
          <xsl:when test="@type='string' and count(value)=0">
            <!-- note, that if count(value)>0, it's a enum/list instead -->
            <xsl:attribute name="type">xs:string</xsl:attribute>
            <xsl:call-template name="annotateAttrs"/>
          </xsl:when>
          <xsl:otherwise>
            <xs:annotation>
              <xs:documentation>
                <xsl:if test="@type and @type!='string'">(<xsl:value-of select="@type"/>)</xsl:if>
                <xsl:value-of select="child::text()"/>
              </xs:documentation>
            </xs:annotation>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="count(value)>0">
          <xs:simpleType>
            <xsl:choose>
              <xsl:when test="@name='flags'">
                <xs:list>
                  <xs:simpleType>
                    <xs:restriction base="xs:string">
                      <xsl:apply-templates select="value"/>
                    </xs:restriction>
                  </xs:simpleType>
                </xs:list>
              </xsl:when>
              <xsl:when test="@name='buttons'">
                <!-- bah! We cannot do anything useful here :(
                XML Schema only supports space-separated lists, and Mozilla wants us to use commas.
                -->
                <xs:restriction base="xs:string">
                  <xsl:apply-templates select="value"/>
                </xs:restriction>
              </xsl:when>
              <xsl:otherwise>
                <xs:restriction base="xs:string">
                  <xsl:apply-templates select="value"/>
                </xs:restriction>
              </xsl:otherwise>
            </xsl:choose>
          </xs:simpleType>
        </xsl:if>
      </xs:attribute>
    </xsl:if>
  </xsl:template>
  <!-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= -->
  <xsl:template match="value">
    <xsl:choose>
      <xsl:when test="not(contains(child::text(),'(Deprecated)'))">
        <xs:enumeration>
          <xsl:attribute name="value">
            <xsl:value-of select="@name"/>
          </xsl:attribute>
          <xs:annotation>
            <xs:documentation>
              <xsl:if test="@default='true'">(default)</xsl:if>
              <xsl:value-of select="child::text()"/>
            </xs:documentation>
          </xs:annotation>
        </xs:enumeration>
      </xsl:when>
      <xsl:otherwise>
        <xsl:comment>deprecated attribute value <xsl:value-of select="@name"/> omitted</xsl:comment>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- ==================================================== -->
  <!-- actually, not all events apply to all elements -->
  <xsl:template match="event">
    <xsl:if test="starts-with(@name,'on')">
      <xs:attribute type="xul:scriptType">
        <xsl:attribute name="name">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
        <xs:annotation>
          <xs:documentation>
            <xsl:value-of select="text()"/>
          </xs:documentation>
        </xs:annotation>
      </xs:attribute>
    </xsl:if>
  </xsl:template>
  <xsl:template match="object[@name='XULElement']">
    <xsl:apply-templates select="attr"/>
  </xsl:template>
</xsl:stylesheet>
