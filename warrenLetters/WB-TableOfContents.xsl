<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns="http://www.w3.org/1999/xhtml">

    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" include-content-type="no"
        indent="yes"/>

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
    <!--<xsl:variable name="WBPic" select="collection('Letter_Images?select=*.jpeg')"/> -->

    <xsl:template match="/">
        <html>
            <head>
                <title>Warren Behrend’s Last Correspondence and Memorial</title>
                <link rel="stylesheet" type="text/css" href="75.css"/>
            </head>
            <body>
                <nav>
                    <hr/>
                    <p class="navbar"><a href="index.html">Home</a> | <a href="calendarPage.html"
                            >Behrend Calendars</a> | <a href="travelLettersPage.html">Behrend Travel
                            Letters</a> | <a href="sipleLettersPage.html">Behrend Siple Letter</a> |
                            <a href="warrenLettersPage.html">Behrend Warren Letters</a> | <a
                            href="search.html">Search</a></p>
                    <hr/>
                </nav>
                <div class="block">
                    <h2>Warren Behrend Letters</h2>
                    <p>This website is dedicated to presenting and marking up in text the final
                        letters written by Warren Behrend shortly before he passed away in a car
                        accident on an icy day in December of 1929. The letters in question were
                        directed to his mother and father, Mary and Ernst Behrend. Mary Behrend
                        later sold the family's land to Penn State. Our goal is to enlighten people
                        on the life of Mary Behrend's son Warren and how he spent his final days
                        before his death.</p>
                </div>
                <section id="toc">
                    <h2>Contents</h2>
                    <ul>
                        <xsl:apply-templates select="$allCollections//xml" mode="toc">
                            <xsl:sort select="descendant::date[1]"/>
                        </xsl:apply-templates>
                    </ul>
                </section>
                <footer class="main">
                    <img src="images/pennStateHorizontal.png" class="pennStateFooter"/>
                    <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>.
                </footer>
            </body>
        </html>
    </xsl:template>

    <!--Templates in toc mode for the table of contents -->
    <xsl:template match="xml" mode="toc">
        <li>
            <a href="warrenLetters/{current()/base-uri() ! tokenize(., '/')[last()] ! substring-before(., '.xml')}.html">
                <xsl:apply-templates select="descendant::title/@titleId"/></a>
        </li>
    </xsl:template>
</xsl:stylesheet>
