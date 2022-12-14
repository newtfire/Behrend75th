<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Guide to People, Places, and Things Mentioned in this Letter</title>
            </head>
            <body>            
                <h1>Guide to People, Places, and Things Mentioned in this Letter</h1>
                <div>
                    <xsl:apply-templates/>
                </div>
                
            </body>
            
        </html>
    </xsl:template>
    <xsl:template match="person | place |thing">
        <xsl:apply-templates select="name"/>
        <ul>
                <xsl:apply-templates select="*[not(name()='name')]"/>
        </ul>
    </xsl:template>
    <xsl:template match="name">
        
        <h3>
            <xsl:apply-templates/>
        </h3>
    </xsl:template>
    <xsl:template match="role | desc | coords">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <xsl:template match="graphic">
        <li><figure><img src="{@src}" alt="{@alt}"/>
            <figcaption>
                <xsl:value-of select="@alt"/>
            </figcaption>
        </figure></li>
        </xsl:template>
</xsl:stylesheet>