<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs math" version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" include-content-type="no"
        indent="yes"/>
    
    <!-- This html layout is based on WB75v1.xsl for Warren Letters. -->
    
    <xsl:variable name="travelColl" as="document-node()+"
        select="collection('XMLforThetravelProjects/?select=*.xml')"/>
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="webstyle.css"/>
                <title>Behrend Travel Letters</title>
            </head>
            <body>
                <h1>Behrends Travel Adventures</h1>
                <section id="toc">
                    <h2>Contents</h2>
                    <ul>
                        <xsl:apply-templates select="$travelColl//xml" mode="toc">
                            <xsl:sort select="descendant::date[1]/@when"/>
                        </xsl:apply-templates>
                    </ul>
                </section>
                
                <section id="fulltext">
                    <xsl:for-each select="$travelColl">
                        <section class="document">
                            <div class="docImage">
                                <xsl:apply-templates select="descendant::figure"/>
                            </div>
                            <div class="transcript">
                                <xsl:apply-templates select="descendant::xml">
                                    <xsl:sort
                                        select="descendant::date[1]/@when"
                                    />
                                </xsl:apply-templates>
                            </div>
                        </section>
                    </xsl:for-each>
                </section>
                <!--            <a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.-->
            </body>
        </html>
    </xsl:template>
    
    <!--Templates in toc mode for the table of contents -->
    <xsl:template match="xml" mode="toc">
        <li>
            <a href="#{descendant::date[1]/@when}">
                <xsl:value-of select="base-uri() ! tokenize(., '/')[last()]"/>
                <xsl:text>-</xsl:text>
                <xsl:value-of select="descendant::date[1]/@when"/>
                
            </a>
        </li>
    </xsl:template>
    
    <xsl:template match="xml">
        <a href="#{descendant::h1}">
            <h2 id="{descendant::date[1]/@when}">
                <xsl:value-of select="current() ! base-uri() ! tokenize(., '/')[last()]"/>
                <xsl:text>-</xsl:text>
                <xsl:apply-templates select="descendant::date[1]/@when"/>
            </h2>
        </a>
        <div class="letter">
            <xsl:comment>WHAT FILE AM I? <xsl:value-of select="current() ! base-uri() ! tokenize(., '/')[last()]"/></xsl:comment>
            <xsl:comment>WHAT IS MY DATE LAST DIGITS? <xsl:value-of select="(current()//date[@when])[1]/@when ! tokenize(., '-')[last()] ! number(.)"/></xsl:comment>
            
            <div class="header">
                <xsl:value-of select="descendant::date[1]/@when"/>
            </div>
            <p>
                <xsl:apply-templates select="descendant::p"/>
            </p>
        </div>
    </xsl:template>
    
    <!--    <xsl:template match="timePeriod">
        <span class="Period">
            <xsl:apply-templates/>
        </span>
    </xsl:template>-->
    
    <xsl:template match="dateLine">
        <div class="dateLine">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="date">
        <span class="date">
            <b>
                <i>
                    <xsl:apply-templates/>
                </i>
            </b>
        </span>
    </xsl:template>
    
    <xsl:template match="p">
        <p id="{base-uri() ! tokenize(., '/')[last()]}-n-{preceding::p => count()+1}">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="meal">
        <span class="meal">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="figure">
        <figure>
            <img src="{graphic/@url}" alt="{caption}"/>
            <figcaption>
                <xsl:apply-templates select="caption"/>
            </figcaption>
        </figure>
    </xsl:template>
    
    <xsl:template match="placeName">
        <span class="place">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="persName">
        <span class="person">
            <b>
                <i>
                    <xsl:apply-templates/>
                </i>
            </b>
        </span>
    </xsl:template>
    
    <xsl:template match="transport">
        <span class="transport">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="u">
        <span class="underlined">
            <u>
                <xsl:apply-templates/>
            </u>
        </span>
    </xsl:template>
    
    <xsl:template match="x">
        <span class="x" title="{@rw}">
            <s>
                <xsl:apply-templates/>
            </s>
        </span>
    </xsl:template>
    
    <xsl:template match="misspelling">
        <span class="spelling" title="{@word}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!--    <xsl:template match="item">
        <span class="item">
            <xsl:apply-templates/>
        </span>
    </xsl:template>-->
    
    <xsl:template match="hand">
        <span class="hand">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="fade">
        <span class="fade">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="merge">
        <span class="merge">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!--    <xsl:template match="money">
        <span class="money">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="day">
        <span class="day">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="drink">
        <span class="drink">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="signOff">
        <span class="signOff">
            <xsl:apply-templates/>
        </span>
    </xsl:template>-->
    
    <xsl:template match="pencil">
        <span class="pencil">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="typeWritten">
        <div class="type">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <!--    
    <xsl:template match="animal">
        <span class="animal">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="nationality">
        <span class="nationality">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="holiday">
        <span class="holiday">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="number">
        <span class="number">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="language">
        <span class="language">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="measure">
        <span class="measure">
            <xsl:apply-templates/>
        </span>
    </xsl:template>-->
    
    <xsl:template match="front">
        <div class="front">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="back">
        <div class="back">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!--    <xsl:template match="readers">
        <span class="readers">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="month">
        <span class="month">
            <xsl:apply-templates/>
        </span>
    </xsl:template>-->
    
    <xsl:template match="eSpace">
        <span class="space" title="She left a space.">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
</xsl:stylesheet>
