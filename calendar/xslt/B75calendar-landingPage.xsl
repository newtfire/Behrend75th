<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml" version="3.0">

    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" include-content-type="no"
        indent="yes"/>

    <xsl:variable name="MBCal" select="collection('../tei/?select=*.xml')"/>
    <xsl:variable name="dateList" as="xs:string+">
        <xsl:for-each select="$MBCal//div2/@xml:id">
            <xsl:sort select="."/>
            <xsl:value-of select="."/>
        </xsl:for-each>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:result-document method="xhtml" html-version="5" omit-xml-declaration="yes"
            include-content-type="no" indent="yes" href="../../docs/calendarPage.html">

            <html lang="en-US" xmlns="http://www.w3.org/1999/xhtml">
                <head>
                    <link rel="stylesheet" type="text/css" href="75.css"/>
                    <title>Calendars</title>
                </head>
                <body>
                    <h2>Behrend Calendars</h2>
                    <nav class="navbar">
                        <ul>
                            <li>
                                <a href="index.html">Home</a>
                            </li>
                            <li>
                                <a href="calendarPage.html">Behrend Calendars</a>
                            </li>
                            <li>
                                <a href="travelLettersPage.html">Behrend Travel Letters</a>
                            </li>
                            <li>
                                <a href="sipleLettersPage.html">Behrend Siple Letters</a>
                            </li>
                            <li>
                                <a href="warrenLettersPage.html">Behrend Warren Letters</a>
                            </li>
                            <li>
                                <a href="search.html">Search</a>
                            </li>
                        </ul>
                    </nav>
                    <div class="block">
                        <p>One staple archive of Behrend 75 is the collection of calendar dates that
                            span throughout the 1900s. These calendar entries were simple
                            illustrations with ancedotes of what occurred on that day. Though
                            hundreds of these were made time has not treated the calendar pages very
                            well. Only 34 pages remain, but they will be held as a special portion
                            of Penn State Behrend history as time passes by.</p>
                    </div>
                    <section id="toc">
                        <h2>Table of Contents</h2>
                        <ul>
                            <xsl:apply-templates select="$MBCal//text//date" mode="toc">

                                <xsl:sort select="@when"/>
                            </xsl:apply-templates>
                        </ul>
                    </section>
                </body>
            </html>
        </xsl:result-document>

        
    </xsl:template>

    <xsl:template match="date" mode="toc">
        <xsl:param name="filename" tunnel="yes"/>
        <li>
            <a href="e-{@when}.html">
                <xsl:choose>
                    <xsl:when test="@when = $filename ! substring-after(., '-')">
                        <b>
                            <xsl:apply-templates mode="toc"/>
                        </b>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates mode="toc"/>
                    </xsl:otherwise>
                </xsl:choose>
            </a>
        </li>
    </xsl:template>

    <xsl:template match="div2">
        <section id="{@xml:id}" class="document">
            <div class="facsblock">
                <figure>
                    <img src="photos/{@facs!tokenize(.,'/')[last()]}"
                        alt="{descendant::date}: {descendant::figDesc ! normalize-space()}"
                        title="{descendant::date}: {descendant::figDesc ! normalize-space()}"
                        class="entry"/>
                    <figcaption>
                        <xsl:apply-templates select="descendant::figDesc"/>
                        <xsl:text>—</xsl:text>
                        <xsl:value-of select="descendant::figDesc/@resp"/>
                    </figcaption>
                </figure>


            </div>
            <div class="calText">
                <div class="transcript">
                    <xsl:apply-templates select="descendant::ab"/>
                </div>
                <div class="note">
                    <xsl:apply-templates select="descendant::note"/>
                </div>
            </div>
        </section>
    </xsl:template>

    <xsl:template match="note">
        <p class="note">
            <xsl:apply-templates/>
            <xsl:text>—</xsl:text>
            <xsl:value-of select="@resp"/>
        </p>
    </xsl:template>


    <xsl:template match="lb">
        <br/>
    </xsl:template>
    <xsl:template match="lb" mode="toc">
        <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template match="del">
        <span class="x">
            <xsl:apply-templates/>
        </span>

    </xsl:template>

    <!-- 2022-12-08 ebb: Adding the following templates to differentiate HTML output for 
    calendar print vs. Mary Behrend's various modes of handwriting. -->

    <xsl:template match="fw">
        <p class="fw">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="ab">
        <xsl:choose>
            <xsl:when test="@hand">
                <p class="{@hand ! substring-after(., '#')}">
                    <xsl:apply-templates/>
                </p>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:apply-templates/>
                </p>
            </xsl:otherwise>

        </xsl:choose>
    </xsl:template>


    <xsl:template match="add[@hand]">
        <span class="{@hand ! substring-after(., '#')}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="emph">

        <span class="underline">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="rs">
        <xsl:choose>
            <xsl:when test="@type = 'location'">
                <span class="place">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="{@type}">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

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
