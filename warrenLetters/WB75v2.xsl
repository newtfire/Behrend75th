<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">

    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" include-content-type="no"
        indent="yes"/>

    <!--<xsl:variable name="WBColl" select="collection('XML?select=*.xml')"/>-->
    <!--<xsl:variable name="WBPic" select="collection('Letter_Images?select=*.jpeg')"/> -->

    <xsl:variable name="memorialPages" as="document-node()+"
        select="collection('XML/dividedPages/memorialPages/?select=*.xml')"/>
    <xsl:variable name="parentsLetter" as="document-node()+"
        select="collection('XML/dividedPages/Parents-Letter/?select=*.xml')"/>
    <xsl:variable name="warrenLetter1" as="document-node()+"
        select="collection('XML/dividedPages/WarrenLetter1/?select=*.xml')"/>
    <xsl:variable name="warrenLetter2" as="document-node()+"
        select="collection('XML/dividedPages/WarrenLetter2/?select=*.xml')"/>

    <xsl:variable name="allCollections" as="document-node()+"
        select="($memorialPages | $parentsLetter | $warrenLetter1 | $warrenLetter2)"/>

    <xsl:template match="/">


        <section id="fulltext">
            <xsl:for-each select="$allCollections">
                <xsl:sort select="descendant::date[1]"/>
                <xsl:variable name="currentCollection" as="document-node()+" select="current()"/>
                <xsl:variable name="filename" as="xs:string" select="$currentCollection/base-uri() ! tokenize(., '/')[last()] ! substring-before(., '.xml')"/>
                <xsl:result-document method="xhtml"
                    href="../docs/warrenLetters/{$filename}.html">
                    <html>
                        <head>
                            <title>Warren Behrend’s Last Correspondence and Memorial</title>
                            <link rel="stylesheet" type="text/css" href="../75.css"/>
                            <script type="text/javascript" src="../respMenu.js">
                                /**/</script>
                            <meta name="docImage" class="staticSearch_docImage" content="images/{descendant::figure/graphic/@src ! tokenize(., '/')[last()]}"/>
                        
                            <meta name="Search in" class="staticSearch_desc" content="Warren Behrend Letters"/>
                            <meta name="dcterms.date" content="{(descendant::date[@when])[1]/@when}"/>
                            <meta name="Date range" class="staticSearch_date" content="{(descendant::date[@when])[1]/@when}"/>
                           
                            <xsl:for-each select="descendant::person  ! normalize-space() => distinct-values()">
                                <meta name="dcterms.subject" content="{current()}"/>
                                <meta name="People involved" class="staticSearch_feat" content="{current()}"/>
                            </xsl:for-each>
                            
                            <xsl:for-each select="descendant::place  ! normalize-space() => distinct-values()">
                                <meta name="dcterms.subject" content="{current()}"/>
                                <meta name="Places involved" class="staticSearch_feat" content="{current()}"/>
                            </xsl:for-each>
                            
                            <xsl:for-each select="(descendant::boat | descendant::transport | descendant::car)  ! normalize-space() => distinct-values()">
                                <meta name="dcterms.subject" content="{current()}"/>
                                <meta name="Transportation involved" class="staticSearch_feat" content="{current()}"/>
                            </xsl:for-each>
                                
                        </head>
                       
                        <body>
                            <div class="sidebar">
                                <button id="closeMe">close ×</button>
                                <section id="toc">
                                    <h3>Table of Contents</h3>
                                    <ul>
                                        <li>
                                            <a href="../index.html">Home</a>
                                        </li>
                                        <li>
                                            <a href="../calendarPage.html">Mary Behrend's Calendar</a>
                                        </li>
                                        <li>
                                            <a href="../warrenLettersPage.html">Warren Behrend
                                                Letters</a>
                                        </li>
                                        <li>
                                            <a href="../sipleLettersPage.html">Siple
                                                Letter</a>
                                        </li>
                                        <li>
                                            <a href="../travelLettersPage.html">Behrend Travel
                                                Letters</a>
                                        </li>
                                        <li><form method="get" action="../search.html"><label for="search">🔎</label>
                                            <input type="text" id="search" name="q"/>
                                            <button type="submit">Search</button>
                                        </form></li>
                                    </ul>
                                    <ul>
                                        <xsl:apply-templates select="$allCollections//xml"
                                            mode="toc">
                                            <xsl:sort select="(descendant::date)[1]"/>
                                            <xsl:with-param as="xs:string" name="filename"
                                                select="$filename" tunnel="yes"/>
                                        </xsl:apply-templates>
                                    </ul>
                                </section>
                            </div>
                            <div id="hamburger">
                                <button id="openMe">☰</button>
                            </div>

                            <!--   <h1>Warren Behrend’s Last Correspondence and Memorial</h1>-->

                            <xsl:comment>New structure for aligning page images and transcripts here.</xsl:comment>
                            <section id="f-{descendant::date[1]}" class="document">
                                <div class="facs">
                                    <figure>
                                        <img
                                            src="images/{descendant::figure/graphic/@src ! tokenize(., '/')[last()]}"
                                            alt="{descendant::figure/graphic/@alt}"
                                            title="{descendant::figure/graphic/@alt}" class="entry"/>
                                        <figcaption>
                                            <xsl:apply-templates
                                                select="descendant::figure/graphic/@alt"/>
                                        </figcaption>
                                    </figure>
                                </div>
                                <div class="transcript">
                                    <xsl:apply-templates select="descendant::meta"/>
                                    <xsl:apply-templates select="descendant::body"/>
                                </div>
                            </section>

                        </body>
                    </html>
                </xsl:result-document>
            </xsl:for-each>
        </section>

    </xsl:template>

    <!--Templates in toc mode for the table of contents -->
    <xsl:template match="xml" mode="toc">
        <xsl:param name="filename" tunnel="yes"/>
        <xsl:variable name="linkText" as="xs:string" select="current()/base-uri() ! tokenize(., '/')[last()] ! substring-before(., '.xml')"/>
        <li>
            <a href="{$linkText}.html">
                <xsl:choose>
                    <xsl:when test="$linkText = $filename">
                        <b>
                            <xsl:apply-templates select="descendant::title/string()"/>
                        </b>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="descendant::title/string()"/>
                    </xsl:otherwise>
                </xsl:choose>
            </a>
        </li>
    </xsl:template>


    <!--Normal templates for fulltext view -->

    <xsl:template match="meta">
        <h2 id="{descendant::title/@titleId}">
            <xsl:apply-templates select="descendant::title"/>
        </h2>
    </xsl:template>

    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>

    </xsl:template>
    <xsl:template match="ln">
        <br/>
        <span class="ln">
            <xsl:apply-templates/>
        </span>
    </xsl:template>


    <xsl:template match="person | persName">
        <span class="person">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="place | placeName">
        <span class="place">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="boat | transport | car">
        <span class="transport">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    

</xsl:stylesheet>
