<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">
    
    <xsl:output method="xml" indent="yes"/>
    
       
    <!-- ########################################################################## -->
    <!--2021-12-01 ebb: This XSLT reads a XML file, and pulls data 
         on persons, places, and other inline markup of interesting names/events. 
        The XSLT outputs these in XML format as a simple  data structure, designed to be filled in with more
        information by the project team. 
        
        The output XML from this transformation is a kind of "site index" or "prosopography" file 
        designed for people to add more markup, and then transform to HTML however you wish for the website.-->
    <!-- ########################################################################## -->
      
  <xsl:template match="/"><!-- ebb: We're totally simplifying this document, so we'll do a template match on the document node to select only the bits we need to pull.-->
      <xml>
          <meta>
              <title>Project Prosopography File</title>
              <context>Markup data extracted on <date><xsl:value-of select="current-dateTime()"/></date></context>
          </meta>
          
          <listPerson>
              <xsl:for-each select="//person ! normalize-space() => distinct-values() => sort()">
                  <person>
                      <persName><xsl:value-of select="current()"/></persName>
                      <note resp=""><xsl:comment>Your comments about this person: do we know anything about them? Or what do you learn from the letters?
                      You can use your initials as the value of @resp to indicate who wrote this note.</xsl:comment></note>
                  </person>
      
              </xsl:for-each>
              
          </listPerson>
          <listPlace>
              <xsl:for-each select="//location ! normalize-space() => distinct-values() => sort()">
                  <place>
                      <placeName><xsl:value-of select="current()"/></placeName>
                      <geo>
                          <lat><xsl:comment>Look up the latitude</xsl:comment></lat>
                          <long><xsl:comment>Look up the latitude</xsl:comment></long>
                      </geo>
                      
                      <note resp=""><xsl:comment>Your comments about this place: Why was it important in your collection? Or what do you learn from the letters?
                      You can use your initials as the value of @resp to indicate who wrote this note.</xsl:comment></note>
                  </place>
                  
              </xsl:for-each>
              
              
          </listPlace>
          
          
      </xml>
  </xsl:template>
    
</xsl:stylesheet>