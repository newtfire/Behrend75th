<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:yxj="http://www.yxj5181.com"
  xpath-default-namespace="http://www.w3.org/1999/xhtml"
  version="3.0"
  xmlns="http://www.w3.org/1999/xhtml">
  
  <xsl:output method="xhtml" html-version="5" include-content-type="no" indent="yes"/>
  
  <xsl:variable name="Coll" select="collection('input/?select=*.html')"/>
  <xsl:variable name="xInterval" select="4"/>
  <xsl:variable name="yInterval" select="20"/>
  <xsl:variable name="colorArray">
    <xsl:value-of select="'darkblue'"/>
  </xsl:variable>
  
  
  <xsl:function name="yxj:tableMaker">
    <xsl:for-each select="$Coll">
      <xsl:variable name="currentFile" select="current()" as="document-node()"/>
      <xsl:variable name="n" select="position()" as="xs:integer"/>
      <xsl:variable name="filename" as="xs:string" select="current() ! base-uri() ! tokenize(., '/')[last()] ! substring-before(., '.')"/>
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
    
    <xsl:function name="yxj:barChart">
      <xsl:variable name="classes" select="$Coll//*/@class ! normalize-space()  => distinct-values()"/>
      <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="1000px">
          <g>
            <xsl:for-each select="$classes">
              <xsl:sort select="$Coll//*[@class=current()] => count()" order="descending"/>
              <xsl:variable name="classNum" select="$Coll//*[@class=current()] => count()"/>
              <line x1="0" y1="{position()*$yInterval}" 
                x2="{$classNum*$xInterval}" y2="{position()*$yInterval}"
                stroke="skyblue" style="stroke-width:15" transform="translate(100,-6)"/>
              <text x="95" y="{position()*$yInterval}" style="font-size:15px" text-anchor="end"><xsl:value-of select="current()"/></text>
            </xsl:for-each>
          </g>
        </svg>
  </xsl:function>
  <xsl:template match="/">
    <html>
      <head>
        <title>Test</title>
        <link rel="stylesheet" type="text/css" href="webstyle.css" />
      </head>
      <body>
        <h1>Table for number of different classes in each site</h1>
        <div class="tables"><xsl:sequence select="yxj:tableMaker()"/></div>
        <br/>
        <h1>Bar chart for number of different classes in all sites</h1>
        <xsl:sequence select="yxj:barChart()"/>
      </body>
    </html>
    </xsl:template>

</xsl:stylesheet>
