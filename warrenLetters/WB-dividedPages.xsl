<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns="http://www.w3.org/1999/xhtml">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
   <!-- <xsl:variable name="WBColl" select="collection('XML?select=*.xml')"/>  -->
    <!--<xsl:variable name="WBPic" select="collection('Letter_Images?select=*.jpeg')"/> -->
    
    <xsl:variable name="memorialPages" as="document-node()+" select="collection('XML/dividedPages/memorialPages/?select=*.xml')"/>
    <xsl:variable name="parentsLetter" as="document-node()+" select="collection('XML/dividedPages/Parents-Letter/?select=*.xml')"/>
    <xsl:variable name="warrenLetter1" as="document-node()+" select="collection('XML/dividedPages/WarrenLetter1/?select=*.xml')"/>
    <xsl:variable name="warrenLetter2" as="document-node()+" select="collection('XML/dividedPages/WarrenLetter2/?select=*.xml')"/>
    
    <xsl:variable name="allCollections" as="document-node()+" select="($memorialPages | $parentsLetter | $warrenLetter1 | $warrenLetter2)"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Warren Behrend’s Last Correspondence and Memorial</title>
                <link rel="stylesheet" type="text/css" href="webstyle.css"/>
                <style type="text/css"> </style>
            </head>
            <!-- <div class="graphics">
                       <xsl:apply-templates select="figure"/>
            </div>-->
            <body>
                <h1>Warren Behrend’s Last Correspondence and Memorial</h1>
                
                <section id="toc">
                    <h2>Contents</h2>
                    <ul>
                        <xsl:apply-templates select="$allCollections//xml" mode="toc">
                            <xsl:sort select="descendant::date[1]"/>
                            
                        </xsl:apply-templates>   
                    </ul>
                </section> 
        
   <section id="fulltext"> 
       <xsl:for-each select="$allCollections">  
        <xsl:variable name="currentCollection" as="document-node()+" select="current()"/>
   <!--     <xsl:result-document method="xhtml" href="docs/{$currentCollection/base-uri() ! tokenize(., '/')[last()]}.html" >  -->
        
               
            <xsl:comment>New structure for aligning page images and transcripts here.</xsl:comment>
             <section class="document">
                 <div class="docImage"><figure>
                     <img src="images/{descendant::figure/graphic/@src ! tokenize(., '/')[last()]}"/>
                     <figcaption><xsl:value-of select="descendant::figure/graphic/@alt"/></figcaption>
                 </figure></div>
                  <div class="transcript"> 
                    <xsl:apply-templates select="descendant::xml">
                        <xsl:sort select="descendant::date[1]"/>
                    </xsl:apply-templates>
                    </div>
                 
                </section>
  
      <!--</xsl:result-document>-->
    </xsl:for-each>
   </section>
            </body>
        </html>
    </xsl:template>
    
    <!--Templates in toc mode for the table of contents -->
    <xsl:template match="xml" mode="toc">
        <li><a href="#{descendant::title/@titleId}"><xsl:apply-templates select="descendant::title/@titleId"/></a></li>

    </xsl:template>
    

    
    <!--Normal templates for fulltext view -->
    <xsl:template match="xml">
        <a href="#{descendant::h1}"><h2 id="{descendant::title/@titleId}"><xsl:apply-templates select="descendant::title"/></h2></a>
      <!--  <div class="img">
            <img src="{//graphic[1]/@src}" alt="{//figure/graphic[1]/@alt}"/>
            <img src="{//graphic[2]/@src}" alt="{//figure/graphic[2]/@alt}"/>
            <img src="{//graphic[3]/@src}" alt="{//figure/graphic[3]/@alt}"/>
            <img src="{//graphic[4]/@src}" alt="{//figure/graphic[4]/@alt}"/>
        </div>-->
        <br/>
        <div class="letter" > <div class="header"><xsl:apply-templates select="descendant::header"/></div>
         <p><xsl:apply-templates select="descendant::p"/></p>
        <div class="closer"><xsl:apply-templates select="descendant::closer"/></div></div>
        
    </xsl:template>
   <!--  <xsl:template match="header">       
        <div class="date"><xsl:apply-templates select="child::date"/></div>
        <div class="greeting"><xsl:apply-templates select="child::greeting"/></div>
    </xsl:template> -->
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
    <xsl:template match="person">
        <span class="person">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="place">
        <span class="place">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="boat">
        <span class="boat">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="car">
        <span class="car">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="emotion">
        <span class="emotion">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
 <!--   <xsl:template match="figure">
        <figure>
            <xsl:apply-templates select="graphic"/>
        </figure>
    </xsl:template>
    <xsl:template match="graphic">
        <img src="{@src}"/>
            
        
    </xsl:template>
  -->
    
</xsl:stylesheet>