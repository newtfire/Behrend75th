<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:yxj="http://www.yxj5181.com" version="3.0"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:output method="xhtml" html-version="5" include-content-type="no" indent="yes"/>

  <xsl:variable name="xInterval" select="4"/>
  <xsl:variable name="yInterval" select="20"/>

  <xsl:function name="yxj:tableMaker" xpath-default-namespace="http://www.w3.org/1999/xhtml">
    <xsl:variable name="Coll" select="collection('input/?select=*.html')"/>
    <xsl:for-each select="$Coll">
      <xsl:variable name="currentFile" select="current()" as="document-node()"/>
      <xsl:variable name="n" select="position()" as="xs:integer"/>
      <xsl:variable name="filename" as="xs:string"
        select="current() ! base-uri() ! tokenize(., '/')[last()] ! substring-before(., '.')"/>
      <xsl:variable name="classes"
        select="current()//*/@class ! normalize-space() => distinct-values()"/>
      
      <div class="table">
        <h2>
          <xsl:value-of select="$filename"/>
        </h2>
        <table>
          <tr>
            <th>tag</th>
            <th>.class</th>
            <th>
              <xsl:text>count</xsl:text>
            </th>
          </tr>
          <xsl:for-each select="$classes">
            <xsl:sort select="count($Coll//*[@class = current()])" order="descending"/>
            <tr>
              <td>
                <!-- This returns the tag name -->
                <xsl:value-of
                  select="$currentFile//*[@class = current()] ! name() => distinct-values()"/>
              </td>
              <td>
                <xsl:choose>
                  <xsl:when test="$currentFile//*[@class = current()] ! name() = 'span'">
                    <span>
                      <xsl:value-of select="current()"/>
                    </span>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="current()"/>
                  </xsl:otherwise>
                </xsl:choose>
              </td>
              <td>
                <xsl:value-of select="count($currentFile//*[@class = current()])"/>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </div>
    </xsl:for-each>
  </xsl:function>



  <xsl:function name="yxj:timeline">
    <xsl:variable name="canlendar" as="document-node()+"
      select="collection('input/calendar/?select=*.xml')"/>
    <xsl:variable name="siple" as="document-node()+" select="collection('input/sipleLetter/?select=*.xml')"/>
    <xsl:variable name="travel" as="document-node()+"
      select="collection('input/travelLetters/?select=*.xml')"/>
    <xsl:variable name="warren" as="document-node()+"
      select="collection('input/warrenLetters/?select=*.xml')"/>
    <xsl:variable name="Coll" as="document-node()+" select="$siple | $travel | $warren"/>


    <xsl:variable name="canlendarDateCountList" as="xs:integer+">
    <xsl:for-each select="$canlendar" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
        <xsl:value-of select="current()//descendant::date[@when] =>count()"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="canlendarDateTotalNum" as="xs:integer" select="sum($canlendarDateCountList)"/>
    
    <g>
      <xsl:for-each select="$canlendar/descendant::date/@when"
        xpath-default-namespace="http://www.tei-c.org/ns/1.0">
        <xsl:sort select="current()" order="ascending"/>
        <text x="10" y="{$yInterval*position()}">
          <xsl:value-of select="current()"/>
        </text>
      </xsl:for-each>
    </g>

    <g transform="translate(0, {($canlendarDateTotalNum)*$yInterval})">
      <xsl:for-each select="$Coll/descendant::date/@when">
        <xsl:sort select="current()" order="ascending"/>
        <text x="10" y="{$yInterval*position()}">
          <xsl:value-of select="current()"/>
        </text>
      </xsl:for-each>
    </g>
  </xsl:function>

  <xsl:template match="/">
    <html>
      <head>
        <title>Test</title>
        <link rel="stylesheet" type="text/css" href="webstyle.css"/>
      </head>
      <body>
        <!--<tables><h1>Table for number of different classes in each site</h1>
        <div class="tables"><xsl:sequence select="yxj:tableMaker()"/></div></tables>-->
        <br/>
        <h1>Timeline</h1>
        <svg xmlns="http://www.w3.org/2000/svg" height="1000px">
          <xsl:sequence select="yxj:timeline()"/>
        </svg>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
