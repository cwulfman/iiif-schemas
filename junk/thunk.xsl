<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.">
    
    <xsl:template match="/">
        <xsl:variable name="in">
            { "this" : "is" }
        </xsl:variable>
        
        <xsl:value-of select="json-to-xml($in)"/>
    </xsl:template>
    
</xsl:stylesheet>