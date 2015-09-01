<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:bgf="http://planet-sl.org/bgf" xmlns:xbgf="http://planet-sl.org/xbgf" version="1.0">
	<xsl:output method="xml" encoding="UTF-8"/>
	<xsl:param name="name"/>
	<xsl:template match="/grammar">
		<entry>
			<name><xsl:value-of select="$name"/></name>
			<xsl:if test="source">
				<!-- <xsl:copy-of select="source"/> -->
				<source>
					<xsl:copy-of select="source/*[local-name()!='link' and local-name()!='readme']"/>
				</source>
			</xsl:if>
			<xsl:if test="source/readme">
				<readme/>
			</xsl:if>
			<xsl:copy-of select="source/link"/>
			<grammar>
				<dir>fetched</dir>
				<level>0</level>
				<method>?</method>
				<format>?</format>
			</grammar>
			<xsl:if test="extraction">
				<grammar>
					<of>
						<xsl:value-of select="source/title"/>
					</of>
					<dir>extracted</dir>
					<level>1</level>
					<method>automatic</method>
					<derivedFrom>fetched</derivedFrom>
					<!--  -->
					<toolused>
						<xsl:value-of select="local-name(extraction/*)"/>
						<xsl:text>2bgf</xsl:text>
					</toolused>
				</grammar>
			</xsl:if>
		</entry>
	</xsl:template>
</xsl:stylesheet>
