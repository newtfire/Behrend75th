<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
    <xsl:variable name="MBCal" as="document-node()" select="collection('../xml/?select=lettertefft.xml')"/>
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
        
        <xsl:for-each select="$MBCal/xml">
            <xsl:variable name="filename" as="xs:string" select="descendant::date[1]/@when"/>
            <xsl:result-document method="xhtml" html-version="5" omit-xml-declaration="yes" include-content-type="no"
                indent="yes" href="../../../docs/siple/{$filename}.html" >
            
           
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
                            <a href="../index.html">Home</a> | 
                            <a href="../calendarPage.html">Behrend Calendars</a> | 
                            <a href="../travelLettersPage.html">Behrend Travel Letters</a> | 
                            <a href="../sipleLettersPage.html">Behrend Siple Letters</a> | 
                            <a href="../warrenLettersPage.html">Behrend Warren Letters</a> | <a href="search.html">Search</a></p>
                        <hr/>
                    </nav>
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
            <a href="calendar/e-{@when}.html">
                <xsl:apply-templates mode="toc"/>
            </a>
        </li>
    </xsl:template>
    
    <xsl:template match="xml">
        <section id="{descendant::date[1]/@when}" class="document">
            <div class="facsblock">
                <figure>
                    <img src="photos/letter_hires_cropped.png" alt="{descendant::date}: {descendant::figDesc ! normalize-space()}" title="{descendant::date}: {descendant::figDesc ! normalize-space()}" class="entry"/>
                    <figcaption><xsl:apply-templates select="descendant::figDesc"/><xsl:text>—</xsl:text><xsl:value-of select="descendant::figDesc/@resp"/></figcaption>
                </figure>
                
                <div class="transcript">
                    <p>
                        <xsl:apply-templates select="descendant::body"/>
                    </p>
                </div>
            </div>
            
            
        </section>
    </xsl:template>
    

    <xsl:template match="p">
        <xsl:apply-templates/>
        <br/>
    </xsl:template>
    <xsl:template match="ln">
        <br/><span class="ln"><xsl:apply-templates/></span>
    </xsl:template>
    <xsl:template match="title"><xsl:apply-templates/></xsl:template>
    <xsl:template match="fw">
        
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