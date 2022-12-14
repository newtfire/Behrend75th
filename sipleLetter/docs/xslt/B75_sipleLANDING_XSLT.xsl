<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml" version="3.0">

    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" include-content-type="no"
        indent="yes"/>

    <xsl:variable name="descFile" as="document-node()" select="doc('../xml/desc.xml')"/>
    <xsl:variable name="inputFile" as="document-node()"
        select="collection('../xml/?select=lettertefft.xml')"/>

    <xsl:template match="/">
        <xsl:result-document method="xhtml" html-version="5" omit-xml-declaration="yes"
            include-content-type="no" indent="yes" href="../../../docs/sipleLettersPage.html">
            <xsl:for-each select="$inputFile">
                <html lang="en-US">
                    <head>
                        <title>Letter from Paul Siple</title>
                        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                        <!--ebb: The line above helps your HTML scale to fit lots of different devices. -->
                        <meta name="docImage" content="siple/photos/letter_hires_cropped.png"/>

                        <meta name="Search in" class="staticSearch_desc" content="Siple Letter"/>
                        <meta name="dcterms.date" content="{(descendant::date)[1]/@when}"/>
                        <meta name="Date range" class="staticSearch_date"
                            content="{(descendant::date)[1]/@when}"/>

                        <xsl:for-each
                            select="descendant::persName ! normalize-space() => distinct-values()">
                            <meta name="dcterms.subject" content="{current()}"/>
                            <meta name="People involved" class="staticSearch_feat"
                                content="{current()}"/>
                        </xsl:for-each>

                        <xsl:for-each
                            select="descendant::placeName ! normalize-space() => distinct-values()">
                            <meta name="dcterms.subject" content="{current()}"/>
                            <meta name="Places involved" class="staticSearch_feat"
                                content="{current()}"/>
                        </xsl:for-each>

                        <xsl:for-each
                            select="descendant::transport ! normalize-space() => distinct-values()">
                            <meta name="dcterms.subject" content="{current()}"/>
                            <meta name="Transportation involved" class="staticSearch_feat"
                                content="{current()}"/>
                        </xsl:for-each>


                        <link rel="stylesheet" type="text/css" href="75.css"/>
                        <script type="text/javascript" src="respMenu.js">
                            /**/</script>
                    </head>
                    <body>
                        <div class="sidebar">
                            <button id="closeMe">close ??</button>
                            <section id="toc">
                                <h3>Table of Contents</h3>
                                <ul>
                                    <li>
                                        <a href="index.html">Home</a>
                                    </li>
                                    <li>
                                        <a href="calendarPage.html">Mary Behrend's Calendar</a>
                                    </li>
                                    <li>
                                        <a href="warrenLettersPage.html">Warren Behrend Letters</a>
                                    </li>
                                    <li>
                                        <a href="sipleLettersPage.html">
                                            <b>Siple Letter</b>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="travelLettersPage.html">Behrend Travel Letters</a>
                                    </li>
                                    <li>
                                        <form method="get" action="search.html">
                                            <label for="search">????</label>
                                            <input type="text" id="search" name="q"/>
                                            <button type="submit">Search</button>
                                        </form>
                                    </li>
                                </ul>
                            </section>
                        </div>
                        <div id="hamburger">
                            <button id="openMe">???</button>
                        </div>

                        <section id="f-{descendant::date[1]/@when}" class="document">
                            <div class="facs">
                                <figure>
                                    <img src="siple/photos/letter_hires_cropped.png"
                                        alt="{descendant::date}: {descendant::figDesc ! normalize-space()}"
                                        title="{descendant::date}: {descendant::figDesc ! normalize-space()}"
                                        class="entry"/>
                                    <figcaption>
                                        <xsl:apply-templates select="descendant::figDesc"/>
                                        <xsl:text>???</xsl:text>
                                        <xsl:value-of select="descendant::figDesc/@resp"/>
                                    </figcaption>
                                </figure>
                            </div>
                            <div class="transcript">
                                <xsl:apply-templates
                                    select="descendant::head | descendant::body | descendant::foot"
                                />
                            </div>
                        </section>
                        <section class="extra">
                            <div>
                                <xsl:apply-templates select="$descFile" mode="desc"/>
                            </div>
                        </section>
                    </body>
                </html>
            </xsl:for-each>
        </xsl:result-document>
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
    <xsl:template match="title">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="fw"> </xsl:template>
    <xsl:template match="persName">
        <span class="person">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="placeName">
        <span class="place">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="boat | transport | car">
        <span class="transport">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- ebb: DESC MODE for the guide to people, places, things -->
    <xsl:template match="title" mode="desc">
        <h2>
            <xsl:apply-templates mode="desc"/>
        </h2>
    </xsl:template>
    <xsl:template match="person | place | thing" mode="desc">
        <xsl:apply-templates select="name"/>
        <ul>
            <xsl:apply-templates select="*[not(name() = 'name')]" mode="desc"/>
        </ul>
    </xsl:template>
    <xsl:template match="name">

        <h3>
            <xsl:apply-templates mode="desc"/>
        </h3>
    </xsl:template>
    <xsl:template match="role | desc | coords" mode="desc">
        <li>
            <xsl:apply-templates mode="desc"/>
        </li>
    </xsl:template>
    <xsl:template match="graphic" mode="desc">
        <li>
            <figure>
                <img src="siple/{@src}" alt="{@alt}"/>
                <figcaption>
                    <xsl:value-of select="@alt"/>
                </figcaption>
            </figure>
        </li>
    </xsl:template>
</xsl:stylesheet>
