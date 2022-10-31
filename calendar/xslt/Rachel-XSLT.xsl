<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
    <xsl:variable name="MBCal" select="collection('../tei/?select=*.xml')"/>
    <xsl:template match="/">
        <html>
            <head>
                <title><xsl:apply-templates select="descendant::title"/></title>
                <link rel="stylesheet" type="text/css" href="../styling.css"/>
            </head> 
            <body>
                <div class="navbar">
                    <h1 class="pageName">Mary Behrend's 1909 Calendar</h1>
                    <a href="../index.html" class="header">Home</a>
                    <a href="../about.html" class="header">History</a>
                    <a href="../authors.html" class="header">Authors</a>
                    <a href="../archive.html" class="header">Archive</a>
                    <!--  <a>additional info</a>
            <a>additional info</a> -->
                    <a href="https://github.com/arrowarchive/behrendcalendar" class="header">Code View</a>
                    
                </div>
                <h1>Group XSLT</h1>
                 <section id="toc">
                    <h2>Table of Contents</h2>
                    <ul>
                        <xsl:apply-templates select="$MBCal//text//date" mode="toc">
                            
                            <xsl:sort select="@when"/>
                        </xsl:apply-templates>
                    </ul>
                </section>
                <section id="fulltext">
                    <xsl:apply-templates select="$MBCal//div2">
                        
                        <xsl:sort select="descendant::date/@when"/>
                    </xsl:apply-templates>
                    
                </section>
                
            </body>
            
        </html>
        
        
    </xsl:template>
    
    <xsl:template match="date" mode="toc">
        <li>
            <a href="#e-{@when}">
                <xsl:apply-templates mode="toc"/>
            </a>
        </li>
    </xsl:template>
    
    <xsl:template match="div2">
        <section id="{@xml:id}">
            <div class="facsblock">
                <figure>
                    <img src="{@facs}" alt="{descendant::date}: {descendant::figDesc ! normalize-space()}" title="{descendant::date}: {descendant::figDesc ! normalize-space()}" class="entry"/>
                    <figcaption><xsl:apply-templates select="descendant::figDesc"/><xsl:text>—</xsl:text><xsl:value-of select="descendant::figDesc/@resp"/></figcaption>
                </figure>
                
                <div class="transcript">
                    <xsl:apply-templates select="descendant::ab"/>
                </div>
            </div>
            <div class="note">
                <xsl:apply-templates select="descendant::note"/>
            </div>
            
        </section>
    </xsl:template>
    
    <xsl:template match="note">
        <p class="note"><xsl:apply-templates/><xsl:text>—</xsl:text><xsl:value-of select="@resp"/></p>
    </xsl:template>
    
    
    <xsl:template match="lb">
        <br/>
    </xsl:template>
    <xsl:template match="lb" mode="toc">
        <xsl:text> </xsl:text>
    </xsl:template>
    
    <!--  <xsl:template match="facs">
        <a href="#{@xml:id}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    
    <xsl:template match="title" mode="toc">
        <li>
            <a href="#{@xml:id}">
                <span class="date"><xsl:apply-templates/></span>
            </a>
        </li>
    </xsl:template>-->
    
</xsl:stylesheet>