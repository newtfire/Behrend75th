<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs math" version="3.0">

    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" include-content-type="no"
        indent="yes"/>

    <xsl:variable name="travelColl" as="document-node()+"
        select="collection('xml-letters/?select=*.xml')"/>

    <xsl:template match="/">
        <xsl:result-document method="xhtml" html-version="5" omit-xml-declaration="yes"
            include-content-type="no" indent="yes" href="../docs/travelLettersPage.html">
            <html>
                <head>
                    <link rel="stylesheet" type="text/css" href="75.css"/>
                    <title>Behrend Travel Letters</title>
                </head>
                <body>
                    <nav>
                        <hr/>
                        <p class="navbar"><a href="index.html">Home</a> | <a
                                href="calendarPage.html">Behrend Calendars</a> | <a
                                href="travelLettersPage.html">Behrend Travel Letters</a> | <a
                                href="sipleLettersPage.html">Behrend Siple Letters</a> | <a
                                href="warrenLettersPage.html">Behrend Warren Letters</a> | <a
                                href="search.html">Search</a></p>
                        <hr/>
                    </nav>
                    <div class="block">
                        <h2>Behrend Travel Letters</h2>
                        <p>Welcome to the Behrend Travel Letters page! This page shows all the trips
                            that the Behrend family took in Europe. The information here gives the
                            dates, places, and detail of transportation. They also show you some
                            important names that were mentioned in the letters. Take a look around
                            and enjoy getting to know the history of the Behrend family's
                            travels!</p>
                    </div>
                    <section id="toc">
                        <h2>Contents</h2>
                        <ul>
                            <xsl:apply-templates select="$travelColl//xml" mode="toc">
                                <xsl:sort select="(descendant::date/@when)[1]"/>
                            </xsl:apply-templates>
                        </ul>
                    </section>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

    <!--Templates in toc mode for the table of contents -->
    <xsl:template match="xml" mode="toc">
        <li>
            <a href="travelLetters/{letter/@xml:id}.html">
                <xsl:value-of select="letter/@xml:id ! tokenize(., '-')[1]"/>
                <xsl:text>, </xsl:text>
                <xsl:apply-templates select="(descendant::date/@when)[1]"/>
            </a>
        </li>
    </xsl:template>
</xsl:stylesheet>
