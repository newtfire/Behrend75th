<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    <xsl:template match="/">
        <html>
            <head>
                <title>Letter from Paul Siple to Mr. Behrend about travel to Antarctica</title>
            </head>
            <body>            
                <h1>Letter from Paul Siple to Mr. Behrend</h1>
                <meta></meta>
                <br/>
                <div>
                    <ul>
                    
                    <xsl:apply-templates/>
                    
                    </ul>
                </div>
                
            </body>
            
        </html>
    </xsl:template>
    
    <xsl:template match="paragraph">
        
        <p> <span class="paragraph"/><xsl:value-of select="@n"/><xsl:apply-templates/></p>

    </xsl:template>
    
    <xsl:template match="head">
        
        <meta><xsl:apply-templates select="child::person"/></meta>
        <br/>
        <meta><xsl:apply-templates select="child::address"/></meta>
        <br/>
        <meta><xsl:apply-templates select="child::city"/></meta>
        <br/>
        <meta><xsl:apply-templates select="child::date"/></meta>
        <br/>
        
    </xsl:template>
    
    <xsl:template match="space">
        <p><xsl:apply-templates/></p>
        
    </xsl:template>
    
    <xsl:template match="closing">
       
        <meta><xsl:apply-templates/></meta>
        <meta><xsl:apply-templates select="child::sign"/></meta>
        <br/>
    </xsl:template>
    <xsl:template match="graphic">
        <div align="right"><img src="../pics/Penguin.PNG"></img></div>
        </xsl:template>
</xsl:stylesheet>