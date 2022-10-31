<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns="http://www.w3.org/1999/xhtml">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
    <xsl:variable name="WBColl" select="collection('XML?select=*.xml')"/>  
    <!--<xsl:variable name="WBPic" select="collection('Letter_Images?select=*.jpeg')"/> -->
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Warren Behrend’s Last Correspondence and Memorial</title>
                <link rel="stylesheet" type="text/css" href="webstyle.css"/>
                <style type="text/css"> </style>
            </head>
           <!-- <div class="graphics">
                       <xsl:apply-templates select="figure"/>
            </div>-->
            <body>
                <h1>Warren Behrend’s Last Correspondence and Memorial</h1>
                
                <section id="toc">
                    <h2>Contents</h2>
                    <ul>
                        <xsl:apply-templates select="$WBColl//xml" mode="toc">
                            <xsl:sort select="descendant::date[1]"/>
                            
                        </xsl:apply-templates>   
                    </ul>
                </section> 
                <br/>
                <section id="fulltext">
                   
                    <xsl:apply-templates select="$WBColl//xml">
                        <xsl:sort select="descendant::date[1]"/>
                    </xsl:apply-templates>
                    
                </section>
  
            </body>
        </html>
    </xsl:template>
    
    <!--Templates in toc mode for the table of contents -->
    <xsl:template match="xml" mode="toc">
        <li><a href="#{descendant::title/@titleId}"><xsl:apply-templates select="descendant::title"/></a></li>

    </xsl:template>
    

    
    <!--Normal templates for fulltext view -->
    <xsl:template match="xml">
        <a href="#{descendant::h1}"><h2 id="{descendant::title/@titleId}"><xsl:apply-templates select="descendant::title"/></h2></a>
        <div class="img">
            <img src="{//graphic[1]/@src}" alt="{//figure/graphic[1]/@alt}"/>
            <img src="{//graphic[2]/@src}" alt="{//figure/graphic[2]/@alt}"/>
            <img src="{//graphic[3]/@src}" alt="{//figure/graphic[3]/@alt}"/>
            <img src="{//graphic[4]/@src}" alt="{//figure/graphic[4]/@alt}"/>
        </div>
        <br/>
        <div class="letter" > <div class="header"><xsl:apply-templates select="descendant::header"/></div>
         <p><xsl:apply-templates select="descendant::p"/></p>
        <div class="closer"><xsl:apply-templates select="descendant::closer"/></div></div>
        
    </xsl:template>
   <!--  <xsl:template match="header">       
        <div class="date"><xsl:apply-templates select="child::date"/></div>
        <div class="greeting"><xsl:apply-templates select="child::greeting"/></div>
    </xsl:template> -->
    <xsl:template match="p">
        <xsl:apply-templates/>
         <br/>
    </xsl:template>
    <xsl:template match="ln">
        <br/><span class="n"><xsl:value-of select="count(preceding::ln)+1"/></span>.
    </xsl:template>
    <xsl:template match="title"><xsl:apply-templates/></xsl:template>
    <xsl:template match="fw">
        
    </xsl:template>
    
 <!--   <xsl:template match="figure">
        <figure>
            <xsl:apply-templates select="graphic"/>
        </figure>
    </xsl:template>
    <xsl:template match="graphic">
        <img src="{@src}"/>
            
        
    </xsl:template>
  -->
    
</xsl:stylesheet>