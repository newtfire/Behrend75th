<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:yxj="http://www.yxj5181.com"
  xpath-default-namespace="http://www.w3.org/1999/xhtml"
  version="3.0"
  xmlns="http://www.w3.org/1999/xhtml">
  
  <xsl:output method="xhtml" html-version="5" include-content-type="no" indent="yes"/>
  
  <xsl:variable name="Coll" select="collection('input/?select=*.html')"/>
  
  <xsl:function name="yxj:tableMaker">
    <xsl:for-each select="$Coll">
      <xsl:variable name="currentFile" select="current()" as="document-node()"/>
      <xsl:variable name="n" select="position()" as="xs:integer"/>
      <xsl:variable name="filename" as="xs:string" select="current() ! base-uri() ! tokenize(., '/')[last()] ! substring-before(., '.')"/>
<!--      <xsl:variable name="elements" select="$Coll[$n]//*[not(self::a)][not(self::p)][not(self::ul)][not(self::li)][not(self::section)][not(self::div)]/@class[.!='ln'][.!='header'] => distinct-values()"/>-->
      <xsl:variable name="classes" select="current()//*/@class ! normalize-space()  => distinct-values()"/>
      
      <div class="table"><h2><xsl:value-of select="$filename"/></h2>
        <table>
          <tr>
            <th>tag</th>
            <th>.class</th>
            <th><xsl:text>count</xsl:text></th>
          </tr> 
          
          <xsl:for-each select="$classes">
            <xsl:sort select="count($Coll//*[@class=current()])" order="descending"/>
            <tr>
              <td><!-- This returns the tag name -->
                <xsl:value-of select="$currentFile//*[@class=current()] ! name() => distinct-values()"/>
              </td>
              <td>
                <xsl:choose>
                  <xsl:when test="$currentFile//*[@class=current()] ! name() = 'span'">
                    <span><xsl:value-of select="current()"/></span>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="current()"/>
                  </xsl:otherwise>
                </xsl:choose>
              </td>
              <td>
                <xsl:value-of select="count($currentFile//*[@class=current()])"/>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </div>
    </xsl:for-each>
    
  </xsl:function>
  <xsl:template match="/">
    <html>
      <head>
        <title>Test</title>
        <link rel="stylesheet" type="text/css" href="webstyle.css" />
      </head>
      <body>
        <h1>The number of different classes in each site</h1>
        <xsl:sequence select="yxj:tableMaker()"/>
      </body>
    </html>
    </xsl:template>

</xsl:stylesheet>
