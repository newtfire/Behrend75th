<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    
<!-- Identity Transformation -->
    
    <xsl:mode on-no-match="shallow-copy"/>
    
<!--    -->
    
    <xsl:template match="paragraph">
        <p n="{preceding-sibling::paragraph => count()+1}"><xsl:apply-templates/></p>
        
       
    </xsl:template>
    
    
</xsl:stylesheet>