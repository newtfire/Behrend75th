<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:yxj="http://www.yxj5181.com"
  version="3.0"
  xmlns="http://www.w3.org/1999/xhtml">
  
  <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
    include-content-type="no" indent="yes"/>
  
  <xsl:variable name="Coll" select="collection('?select=*.xml')"/>
  <xsl:variable name="inFileNmaes" as="xs:string+">
    <xsl:value-of select="'BTLetter'"/>
    <xsl:value-of select="'calendar'"/>
    <xsl:value-of select="'sipleLetter'"/>
    <xsl:value-of select="'warrentLetters'"/>
  </xsl:variable> 
  
  <xsl:function name="yxj:tableMaker">
    <xsl:for-each select="1 to 4">
      <xsl:variable name="n" select="current()"/>
<!--      <xsl:variable name="elements" select="$Coll[$n]//*[not(self::a)][not(self::p)][not(self::ul)][not(self::li)][not(self::section)][not(self::div)]/@class[.!='ln'][.!='header'] => distinct-values()"/>-->
      <xsl:variable name="elements" select="$Coll[$n]//*/@class => distinct-values()"/>
      
      <div class="table"><h2><xsl:value-of select="$inFileNmaes[$n]"/></h2>
        <table>
          <tr>
            <th>tag</th>
            <th>.class</th>
            <th><xsl:text>count</xsl:text></th>
          </tr> 
          <xsl:for-each select="$elements">
            <xsl:sort select="count($Coll//*[./@class=current()])" order="descending"/>
            <tr>
              <td>
                <xsl:value-of select="$Coll[$n]//*[./@class=current()]!name()=> distinct-values()"/>
              </td>
              <td>
                <xsl:choose>
                  <xsl:when test="$Coll[$n]//*[./@class=current()]!name()=> distinct-values() = 'span'">
                    <span><xsl:value-of select="$Coll[$n]//*[./@class=current()]/@class => distinct-values()"/></span>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$Coll[$n]//*[./@class=current()]/@class => distinct-values()"/>
                  </xsl:otherwise>
                </xsl:choose>
              </td>
              <td>
                <xsl:value-of select="count($Coll[$n]//*[./@class=current()])"/>
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
        <div class="center"><xsl:sequence select="yxj:tableMaker()"/></div>
      </body>
    </html>
    </xsl:template>

</xsl:stylesheet>
