<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
    <xsl:variable name="MBCal" select="collection('../tei/?select=*.xml')"/>
    <xsl:template match="/">
        <!--<xsl:result-document method="xhtml" html-version="5" omit-xml-declaration="yes" include-content-type="no"
            indent="yes" href="../../docs/calendarPage.html" >
           
            <html xmlns="http://www.w3.org/1999/xhtml">
                <head>
                    <link rel="stylesheet" type="text/css" href="75.css" />
                    <title>Calendars</title>
                </head>
                <body>
                    <h2>Behrend Calendars</h2>
                    <nav>
                        <hr />
                        <p class="navbar"><a href="index.html">Home</a> | <a href="calendarPage.html">Behrend
                            Calendars</a> | <a href="travelLettersPage.html">Behrend Travel Letters</a> | <a
                                href="sipleLettersPage.html">Behrend Siple Letters</a> | <a
                                    href="warrenLettersPage.html">Behrend Warren Letters</a></p>
                        <hr />
                    </nav>
                    <div class="block">
                        <p>One staple archive of Behrend 75 is the collection of calendar dates that span throughout
                            the 1900s. These calendar entries were simple illustrations with ancedotes of what
                            occurred on that day. Though hundreds of these were made time has not treated the
                            calendar pages very well. Only 34 pages remain, but they will be held as a special
                            portion of Penn State Behrend history as time passes by.</p>
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
                
                
               
        </xsl:result-document>-->
        
        <xsl:for-each select="$MBCal//div2">
            <xsl:variable name="filename" as="xs:string" select="@xml:id"/>
            <xsl:result-document method="xhtml" html-version="5" omit-xml-declaration="yes" include-content-type="no"
                indent="yes" href="../../docs/calendar/{$filename}.html" >
            
           
               <html> 
                   <head>
                       <title>Calendar Entry <xsl:value-of select="@xml:id"/></title>
                       <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                       <!--ebb: The line above helps your HTML scale to fit lots of different devices. -->
                       <link rel="stylesheet" type="text/css" href="../75.css"/>
                       
                       
                   </head>
                <body>
                    <nav>
                        <hr/>
                        <p class="navbar">
                            <!--<a href="../index.html">Home</a> | 
                            <a href="../calendarPage.html">Behrend Calendars</a> | 
                            <a href="../travelLettersPage.html">Behrend Travel Letters</a> | 
                            <a href="../sipleLettersPage.html">Behrend Siple Letters</a> | 
                            <a href="../warrenLettersPage.html">Behrend Warren Letters</a> |--> 
                            <a href="search.html">Search</a></p>
                        <hr/>
                    </nav>
                    <div class="sidebar">
                        <section id="toc">
                            <div class="tocHeader"><h3>Table of Contents</h3></div>
                            <ul>
                                <li><a href="../index.html">Home</a></li>
                                <li><a href="../calendarPage.html">Behrend Calendars</a></li>
                                <li><a href="../travelLettersPage.html">Behrend Travel Letters</a></li>
                                <li><a href="../sipleLettersPage.html">Behrend Siple Letters</a></li>
                                <li><a href="../warrenLettersPage.html">Behrend Warren Letters</a></li>
                            </ul>
                            
                            <ul>    
                                    <xsl:apply-templates select="$MBCal//text//date" mode="toc">
                                        
                                        <xsl:sort select="@when"/>
                                    </xsl:apply-templates>
                                
                            </ul>
                        </section>
                    </div>
                <xsl:apply-templates select="current()">
                    
                    <xsl:sort select="descendant::date/@when"/>
                </xsl:apply-templates>
                
                    <footer class="main">
                        <img src="../images/pennStateHorizontal.png" class="pennStateFooter"/>
                        <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>.
                    </footer>
                </body>
               </html>
            
             </xsl:result-document>
        </xsl:for-each>
        
        

        
    </xsl:template>
    
    <xsl:template match="date" mode="toc">
        <li>
            <a href="e-{@when}.html">
                <xsl:apply-templates mode="toc"/>
            </a>
        </li>
    </xsl:template>
    
    <xsl:template match="div2">
        <section id="{@xml:id}" class="document">
            <div class="facsblock">
                <figure>
                    <img src="photos/{@facs!tokenize(.,'/')[last()]}" alt="{descendant::date}: {descendant::figDesc ! normalize-space()}" title="{descendant::date}: {descendant::figDesc ! normalize-space()}" class="entry"/>
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