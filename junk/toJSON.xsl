<?xml version="1.0" encoding="UTF-8"?>
<!-- See https://github.com/doekman/xml2json-xslt  -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:local="http:/me.org"
    xmlns:json="http://cwulfman.org/ns/json"
    exclude-result-prefixes="xs" version="3.0">
    

    <xsl:output indent="no" omit-xml-declaration="yes" method="text" encoding="UTF-8"
        media-type="text/x-json"/>
    <xsl:strip-space elements="*"/>

    <xsl:function name="json:escape-string" as="xs:string">
        <xsl:param name="input" as="xs:string"/>
        <xsl:variable name="input" as="xs:string">
            <xsl:copy-of select="$input"/>
        </xsl:variable>
        <xsl:variable name="sub1" select="replace($input, '\\', '\\\\')"/>
        <xsl:value-of select="replace($sub1, '&quot;', '\\&quot;')"/>
    </xsl:function>
    
    <xsl:function name="json:quote-string" as="xs:string">
        <xsl:param name="input"/>
        <xsl:sequence select="concat('&quot;', $input, '&quot;')"/>
    </xsl:function>
    
    
    <xsl:function name="json:name">
        <xsl:param name="string"/>
        <xsl:sequence select="json:quote-string(json:escape-string($string))"/>
    </xsl:function>
    
    <xsl:function name="json:value-string">
        <xsl:param name="string"/>
        <xsl:sequence select="json:quote-string(json:escape-string($string))"/>
    </xsl:function>
    
    <xsl:function name="json:value">
        <xsl:param name="value"/>
        <xsl:sequence select="json:value-string($value)"/>
    </xsl:function>
    
    <xsl:function name="json:nvpair">
        <xsl:param name="name"/>
        <xsl:param name="value"/>
        <xsl:sequence select="string-join((json:name($name), json:value($value)), ' : ')"/>
    </xsl:function>
    
    <xsl:function name="json:e_to_nvpair">
        <xsl:param name="input" as="node()" />
        <xsl:sequence select="json:nvpair(name($input), $input/text())"/>
    </xsl:function>
    
    <xsl:function name="json:object">
        <xsl:param name="nvpairs" as="xs:string+" />
        <xsl:text>{ </xsl:text>
        <xsl:for-each select="$nvpairs">
            <xsl:value-of select="current()"/>
            <xsl:if test="position() &lt; last()">
                <xsl:text>, </xsl:text>
            </xsl:if>
        </xsl:for-each>
        <xsl:text> }</xsl:text>
    </xsl:function>
    
    <xsl:template match="test1|test2">
        <xsl:value-of select="json:e_to_nvpair(current())"/>
    </xsl:template>
    
    <xsl:template match="testData">
        <xsl:variable name="pair">
            <xsl:apply-templates />
        </xsl:variable>
        <xsl:sequence select="json:object($pair)"></xsl:sequence>
    </xsl:template>
    
    <xsl:template match="/">
        <top>
            <xsl:apply-templates />
            
        </top>
    </xsl:template>


</xsl:stylesheet>
