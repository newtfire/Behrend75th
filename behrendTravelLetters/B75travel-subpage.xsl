<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs math" version="3.0">

    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" include-content-type="no"
        indent="yes"/>

    <!-- This html layout is based on WB75v1.xsl for Warren Letters. -->

    <xsl:variable name="travelColl" as="document-node()+"
        select="collection('xml-letters/?select=*.xml')"/>

    <xsl:template match="/">
        <xsl:for-each select="$travelColl//letter">
            <xsl:variable name="filename" as="xs:string" select="@xml:id"/>
            <xsl:result-document method="xhtml" html-version="5" omit-xml-declaration="yes"
                include-content-type="no" indent="yes" href="../docs/travelLetters/{$filename}.html">

                <html>
                    <head>
                        <title>Travel Letters <xsl:value-of select="@xml:id"/></title>
                        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                        <!--ebb: The line above helps your HTML scale to fit lots of different devices. -->
                        <link rel="stylesheet" type="text/css" href="../75.css"/>
                        <script type="text/javascript" src="../respMenu.js">
                            /**/</script>
                    </head>
                    <body>
                        <!-- <nav>
                            <hr/>
                            <p class="navbar"><a href="search.html">Search</a></p>
                            <hr/>
                        </nav>-->

                        <div class="sidebar">
                            <button id="closeMe">close ×</button>
                            <section id="toc">
                                <h3>Table of Contents</h3>
                                <ul>
                                    <li>
                                        <a href="../index.html">Home</a>
                                    </li>
                                    <li>
                                        <a href="../calendarPage.html">Behrend Calendar</a>
                                    </li>
                                    <li>
                                        <a href="../travelLettersPage.html">Behrend Travel
                                            Letters</a>
                                    </li>
                                    <li>
                                        <a href="../sipleLettersPage.html">Behrend Siple Letters</a>
                                    </li>
                                    <li>
                                        <a href="../warrenLettersPage.html">Warren Behrend
                                            Letters</a>
                                    </li>
                                    <li>
                                        <a href="../search.html">🔎 Search</a>
                                    </li>
                                </ul>
                                <ul>
                                    <xsl:apply-templates select="$travelColl//xml" mode="toc">
                                        <xsl:sort select="(descendant::date/@when)[1]"/>
                                        <xsl:with-param as="xs:string" name="filename"
                                            select="$filename" tunnel="yes"/>
                                    </xsl:apply-templates>
                                </ul>
                            </section>
                        </div>
                        <div id="hamburger">
                            <button id="openMe">☰</button>
                        </div>

                        <xsl:choose>
                            <xsl:when test="front">
                                <section id="f-{@xml:id}-front" class="document">
                                    <div class="facs">
                                        <xsl:apply-templates select="descendant::figure[1]"/>
                                    </div>
                                    <div class="transcript">
                                        <h2 id="{@xml:id}">
                                            <xsl:value-of select="@xml:id ! tokenize(., '-')[1]"/>
                                            <xsl:text>, </xsl:text>
                                            <xsl:apply-templates
                                                select="(descendant::date/@when)[1]"/>
                                        </h2>
                                        <xsl:apply-templates select="front"/>
                                    </div>
                                </section>
                                <section id="f-{@xml:id}-back" class="document">

                                    <div class="facs">
                                        <xsl:apply-templates select="descendant::figure[2]"/>
                                    </div>
                                    <div class="transcript">
                                        <xsl:apply-templates select="back"/>
                                    </div>
                                </section>

                            </xsl:when>
                            <xsl:otherwise>
                                <section id="f-{@xml:id}" class="document">
                                    <div class="facs">
                                        <xsl:apply-templates select="descendant::figure"/>
                                    </div>
                                    <div class="transcript">
                                        <xsl:apply-templates select="current()"/>
                                    </div>
                                </section>
                            </xsl:otherwise>
                        </xsl:choose>
                        <footer class="main">
                            <img src="../images/pennStateHorizontal.png" class="pennStateFooter"/>
                            <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"
                                    ><img alt="Creative Commons License" style="border-width:0"
                                    src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png"
                            /></a><br/>This work is licensed under a <a rel="license"
                                href="http://creativecommons.org/licenses/by-nc/4.0/">Creative
                                Commons Attribution-NonCommercial 4.0 International License</a>.
                        </footer>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>

    <!--Templates in toc mode for the table of contents -->
    <xsl:template match="xml" mode="toc">
        <xsl:param name="filename" tunnel="yes"/>
        <li>
            <a href="{letter/@xml:id}.html">
                <xsl:choose>
                    <xsl:when test="letter/@xml:id = $filename">
                        <b>
                            <xsl:value-of select="letter/@xml:id ! tokenize(., '-')[1]"/>
                            <xsl:text>, </xsl:text>
                            <xsl:apply-templates select="(descendant::date/@when)[1]"/>
                        </b>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="letter/@xml:id ! tokenize(., '-')[1]"/>
                        <xsl:text>, </xsl:text>
                        <xsl:apply-templates select="(descendant::date/@when)[1]"/>
                    </xsl:otherwise>
                </xsl:choose>
            </a>
        </li>
    </xsl:template>

    <xsl:template match="letter">
        <!--        <a href="#{descendant::h1}">-->
        <h2 id="{@xml:id}">
            <xsl:value-of select="@xml:id ! tokenize(., '-')[1]"/>
            <xsl:text>, </xsl:text>
            <xsl:apply-templates select="(descendant::date/@when)[1]"/>
        </h2>
        <!--</a>-->
        <!--        <div class="letter">-->
        <div class="header">
            <xsl:value-of select="(descendant::date/@when)[1]"/>
        </div>
        <xsl:apply-templates select="descendant::p"/>
        <!--</div>-->
    </xsl:template>

    <xsl:template match="timePeriod">
        <span class="Period">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="time">
        <span class="time">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

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

    <xsl:template match="figure">
        <figure>
            <img src="{graphic/@url}" alt="{caption}" title="{caption}" class="entry"/>
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

    <xsl:template match="animal">
        <span class="animal">
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

    <xsl:template match="front">
        <!--<a href="#{descendant::h1}">
            <h2 id="{base-uri() ! tokenize(., '/')[last()]}1955-07-26">-->
        <h3>Front</h3>
        <!--</a>-->
        <div class="letter">
            <div class="header">
                <xsl:value-of select="(//date/@when)[1]"/>
            </div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="back">
        <!--<a href="#{descendant::h1}">-->
        <!--            <h2 id="{base-uri() ! tokenize(., '/')[last()]}1955-07-26-back">-->
        <h3>Back</h3>
        <!--</a>-->
        <div class="letter">
            <div class="header">
                <xsl:value-of select="(//date/@when)[1]"/>
            </div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>


    <xsl:template match="eSpace">
        <span class="space" title="She left a space.">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

</xsl:stylesheet>
