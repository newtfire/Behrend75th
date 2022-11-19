<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:yxj="http://www.yxj5181.com" version="3.0"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:output method="xhtml" html-version="5" include-content-type="no" indent="yes"/>

  <xsl:variable name="xInterval" select="211"/>
  <xsl:variable name="yInterval" select="20"/>
  <xsl:variable name="colorArray" select="'#0080B1', '#41ACA0', '#8A8D0B', '#80B022'"
    as="xs:string+"/>

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
                    <span class="span">
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
    <!-- variables -->
    <xsl:variable name="calendar" as="document-node()+"
      select="collection('input/calendar/?select=*.xml')"/>
    <xsl:variable name="warren" as="document-node()+"
      select="collection('input/warrenLetters/?select=*.xml')"/>
    <xsl:variable name="siple" as="document-node()+"
      select="collection('input/sipleLetter/?select=*.xml')"/>
    <xsl:variable name="travel" as="document-node()+"
      select="collection('input/travelLetters/?select=*.xml')"/>
    <xsl:variable name="Coll" as="document-node()+" select="$warren, $siple, $travel"/>
    <!--<xsl:variable name="projectNameArray" select="$Coll ! base-uri() ! tokenize(., '/')[last() - 1]"
      as="xs:string+"/>-->
    <xsl:variable name="projectNameArray" as="xs:string+"
      select="'Calendar', 'Warren Letters', 'Siple Letter', 'Travel Letters'"/>
    <xsl:variable name="yearArray" as="xs:string+" select="'1909', '1929', '1935', '1955'"/>

    <xsl:variable name="calendarDateCountList" as="xs:integer+">
      <xsl:for-each select="$calendar" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
        <xsl:value-of select="current()/descendant::date[@when] => count()"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="calendarDateCount" as="xs:integer" select="sum($calendarDateCountList)"/>

    <xsl:variable name="warrenDateCountList" as="xs:integer+">
      <xsl:for-each select="$warren">
        <xsl:value-of select="current()/descendant::date[@when] => count() => count()"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="warrenDateCount" as="xs:integer" select="sum($warrenDateCountList)"/>

    <xsl:variable name="sipleDateCountList" as="xs:integer+">
      <xsl:for-each select="$siple">
        <xsl:value-of select="current()/descendant::date[@when] => count()"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="sipleDateCount" as="xs:integer" select="sum($sipleDateCountList)"/>

    <xsl:variable name="travelDateCountList" as="xs:integer+">
      <xsl:for-each select="$travel">
        <xsl:value-of select="current()/descendant::date[@when] => count()"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="travelDateCount" as="xs:integer" select="sum($travelDateCountList)"/>

    <xsl:variable name="dateCountList" as="xs:integer+"
      select="$calendarDateCount, $warrenDateCount, $sipleDateCount, $travelDateCount"/>
    <xsl:variable name="moveUpUnit" as="xs:integer+"
      select="0, 0, $warrenDateCount, $sipleDateCount + $warrenDateCount"/>

    <xsl:variable name="lineX" select="5"/>

    <!-- Timeline header -->
    <g class="timelineHeader">
      <path d="M881 30H918.238L929 40.5L918.238 51H881V30Z" fill="#B1B1B1"/>
      <xsl:for-each select="1 to 4">
        <xsl:variable name="index" select="current()"/>
        <g id="y{$yearArray[last() + 1 -$index]}">
          <path
            d="M{670 - ($index -1)*$xInterval} 30H{885.238 - ($index -1)*$xInterval}L{896 - ($index -1)*$xInterval} 40.5L{885.238 - ($index -1)*$xInterval} 51H{670 - ($index -1)*$xInterval}V30Z"
            fill="{$colorArray[last() + 1 -$index]}"/>
          <text x="{775.5 - ($index -1)*$xInterval}" y="20" fill="{$colorArray[last() + 1 -$index]}"
            text-anchor="middle" font-size="2em">
            <xsl:value-of select="$yearArray[last() + 1 - $index]"/>
          </text>
          <path
            d="M{775.5 - ($index -1)*$xInterval} 45L{768.139 - ($index -1)*$xInterval} 36H{782.861 - ($index -1)*$xInterval}L{775.5 - ($index -1)*$xInterval} 45Z"
            fill="#D9D9D9"/>
        </g>
      </xsl:for-each>
      <path d="M0 30H37.2381L48 40.5L37.2381 51H0V30Z" fill="#B1B1B1"/>
    </g>

    <!-- timeline for calendar -->
    <g class="calendar" transform="translate(50, {$yInterval*4})" fill="{$colorArray[1]}" >
      <circle cx="{$lineX}" cy="{-0.5 * $yInterval}" r="5"/>
      <text x="{15+$lineX}" y="{-0.5 * $yInterval + 6}" font-size="22px">Calendar</text>


      <g class="calendar-timelineInfo">
        <text x="{20+$lineX}" y="{$yInterval}">Count: <xsl:value-of select="$dateCountList[1]"
          /></text>
        <text x="{20+$lineX}" y="{$yInterval * 2}">Earlist: <xsl:value-of select="($calendar[1]//@when)[1]"/></text>
        <text x="{20+$lineX}" y="{$yInterval * 3}">Latest: <xsl:value-of select="($calendar[last()]//@when)[last()]"/></text>
      </g>


      <xsl:for-each select="$calendar/descendant::date/@when"
        xpath-default-namespace="http://www.tei-c.org/ns/1.0">
        <xsl:sort select="current()" order="ascending"/>
        <text x="{20+$lineX}" y="{$yInterval*position()}">
          <xsl:value-of select="current() ! substring(., 6, 10)"/>
        </text>
        <line x1="{$lineX}" y1="{$yInterval*(position()-1.5)}" x2="{$lineX}"
          y2="{$yInterval*(position()+1)}" style="stroke:{$colorArray[1]};stroke-width:3"/>
      </xsl:for-each>
    </g>

    <!-- timeline for warren, siple, and travel letters -->
    <g transform="translate(50, {$yInterval*4})">
      <xsl:for-each select="$Coll">
        <xsl:sort select="current()/descendant::date/@when" order="ascending"/>
        <xsl:variable name="currentLetterName" as="xs:string" 
          select="current() ! base-uri() ! tokenize(., '/')[last() - 1]"/>
        
        <xsl:variable name="index" as="xs:integer">
          <xsl:choose>
            <xsl:when test="$currentLetterName = 'warrenLetters'">
              <xsl:value-of select="2"/>
            </xsl:when>
            <xsl:when test="$currentLetterName = 'sipleLetter'">
              <xsl:value-of select="3"/>
            </xsl:when>
            <xsl:when test="$currentLetterName = 'travelLetters'">
              <xsl:value-of select="4"/>
            </xsl:when>
          </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="currentLetterNode" as='item()'>
          <xsl:choose>
            <xsl:when test="$currentLetterName = 'warrenLetters'">
              <xsl:value-of select="$warren"/>
            </xsl:when>
            <xsl:when test="$currentLetterName = 'sipleLetter'">
              <xsl:value-of select="$siple"/>
            </xsl:when>
            <xsl:when test="$currentLetterName = 'travelLetters'">
              <xsl:value-of select="$travel"/>
            </xsl:when>
          </xsl:choose>
        </xsl:variable>
        
        <g class="{$currentLetterName}" fill="{$colorArray[$index]}"
          transform="translate({($index - 1)*$xInterval}, {-$moveUpUnit[$index]*$yInterval})">
          <circle cx="{$lineX}" cy="{-0.5 * $yInterval}" r="5"/>
          <!-- text for project name -->
          <text x="{15+$lineX}" y="{(-0.5 + $moveUpUnit[$index]) * $yInterval + 6}" font-size="22px">
            <xsl:value-of select="$projectNameArray[$index]"/>
          </text>
          
          <!-- text for date information: count, earliest, latest -->
          <g class="{$currentLetterName}-timelineInfo"
            transform="translate(0, {$moveUpUnit[$index]*$yInterval})">
            <text x="{20+$lineX}" y="{$yInterval}">Count: <xsl:value-of
                select="$dateCountList[$index]"/></text>
            <text x="{20+$lineX}" y="{$yInterval * 2}">
              <xsl:choose>
                <xsl:when test="$currentLetterName = 'warrenLetters'">
                  Earlist: <xsl:value-of select="'...'"/>
                </xsl:when>
                <xsl:when test="$currentLetterName = 'sipleLetter'">
                  Date: <xsl:value-of select="($siple[1]//@when)[1]"/>
                </xsl:when>
                <xsl:when test="$currentLetterName = 'travelLetters'">
                  Earlist: <xsl:value-of select="'...'"/>
                </xsl:when>
              </xsl:choose>
            </text>
            <text x="{20+$lineX}" y="{$yInterval * 3}">
              <xsl:choose>
              <xsl:when test="$currentLetterName = 'warrenLetters'">
                Latest: <xsl:value-of select="'...'"/>
              </xsl:when>
              <xsl:when test="$currentLetterName = 'travelLetters'">
                Latest: <xsl:value-of select="'...'"/>
              </xsl:when>
              </xsl:choose>
            </text>
          </g>


          <text x="{20+$lineX}" y="{$yInterval*position()}">
            <xsl:value-of select="current()/descendant::date/@when ! substring(., 6, 10)"/>
          </text>
          <line x1="{$lineX}" y1="{$yInterval*(position()-1.5)}" x2="{$lineX}"
            y2="{$yInterval*(position()+1)}" style="stroke:{$colorArray[$index]};stroke-width:3"/>
        </g>
      </xsl:for-each>
    </g>
  </xsl:function>

  <xsl:template match="/">
    <html>
      <head>
        <title>Test</title>
        <link rel="stylesheet" type="text/css" href="webstyle.css"/>
        <script type="text/javascript" src="interact.js"/>
      </head>
      <body>
        <g><!--<tables><h1>Table for number of different classes in each site</h1>
        <div class="tables"><xsl:sequence select="yxj:tableMaker()"/></div></tables>--></g>
        <br/>
        <h1>Timeline</h1>
        <div id="svgTimeline">
          <svg xmlns="http://www.w3.org/2000/svg" height="1000px" width="929px">
            <xsl:sequence select="yxj:timeline()"/>
          </svg>
        </div>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
