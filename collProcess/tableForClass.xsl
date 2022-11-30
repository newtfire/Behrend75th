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

    <xsl:variable name="warrenOrdered" as="item()+">
      <xsl:for-each select="$warren">
        <xsl:sort select="current()" order="ascending"/>
        <xsl:value-of select="current()"/>
      </xsl:for-each>
    </xsl:variable>

    <xsl:variable name="travelOrdered" as="item()+">
      <xsl:for-each select="$travel">
        <xsl:sort select="current()" order="ascending"/>
        <xsl:value-of select="current()"/>
      </xsl:for-each>
    </xsl:variable>

    <xsl:variable name="projectNameArray" as="xs:string+"
      select="'Calendar', 'Warren Letters', 'Siple Letter', 'Travel Letters'"/>
    <xsl:variable name="yearArray" as="xs:string+" select="'1909', '1929', '1935', '1955'"/>

    <xsl:variable name="calendarDateCountList" as="xs:integer+">
      <xsl:for-each select="$calendar" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
        <xsl:value-of select="current()/descendant::date[@when] => count()"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="calendarDateCount" as="xs:integer" select="sum($calendarDateCountList)"/>
    <xsl:variable name="warrenDateCount" as="xs:integer" select="$warren => count()"/>
    <xsl:variable name="sipleDateCount" as="xs:integer" select="$siple => count()"/>
    <xsl:variable name="travelDateCount" as="xs:integer" select="$travel => count()"/>

    <xsl:variable name="lineX" select="5"/>

    <!-- Timeline header -->
    <g id="timelineHeader">
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
    <g id="calendar" transform="translate(50, {$yInterval*4})" fill="{$colorArray[1]}">
      <circle cx="{$lineX}" cy="{-0.5 * $yInterval}" r="5"/>
      <text id="calendarTitle" x="{15+$lineX}" y="{-0.5 * $yInterval + 6}" font-size="22px"
        >Calendar</text>
      <!-- date information of calendar -->
      <g class="timelineInfo">
        <text x="{15+$lineX}" y="{$yInterval}">Count: <xsl:value-of select="$calendarDateCount"
          /></text>
        <text x="{15+$lineX}" y="{$yInterval * 2}">Earlist: <xsl:value-of
            select="($calendar[1]//@when)[1]"/></text>
        <text x="{15+$lineX}" y="{$yInterval * 3}">Latest: <xsl:value-of
            select="($calendar[last()]//@when)[last()]"/></text>
      </g>



      <!-- list of MM-DD -->
      <g class="timeline">
        <xsl:variable name="firstDate" select="($calendar[1]//@when)[1]"/>
        <xsl:for-each select="$calendar/descendant::date/@when"
          xpath-default-namespace="http://www.tei-c.org/ns/1.0">
          <!--<xsl:variable name="dayIntervalFromFirst"
            select="days-from-duration(xs:date(current()) - xs:date($firstDate))"/>-->
          <!--<xsl:variable name="dayInternalFromPrevious"
            select="days-from-duration(xs:date(current()) - xs:date(current()/preceding::date[@when][1]/@when))"/>-->
          <text x="{20+$lineX}" y="{$yInterval * position()}">
            <xsl:value-of select="current() ! substring(., 6, 10)"/>
          </text>

          <!-- <path transform="translate(-3, {$yInterval * $yPos})"
                d="M8 1.5V10.5L3.5 15L9.5 17.5L3.5 23.5L10 26L8 30V41.5" stroke="black"
                stroke-width="3" stroke-linecap="round"/>-->
          <line x1="{$lineX}" y1="{$yInterval*(position() -1.5)}" x2="{$lineX}"
            y2="{$yInterval*(position() + 1)}" stroke-width="3" stroke="{$colorArray[1]}"/>

          <line x1="{$lineX}" y1="{$yInterval * position()}" x2="{$lineX + 10}"
            y2="{$yInterval * position()}" stroke-width="2" transform="translate(0,-4)" stroke="{$colorArray[1]}"/>
        </xsl:for-each>
      </g>
    </g>

    <!-- timeline for warren -->
    <g id="warrenLetters" transform="translate({50 + $xInterval}, {$yInterval*4})">
      <xsl:variable name="index" as="xs:integer" select="2"/>
      <g fill="{$colorArray[$index]}">
        <circle cx="{$lineX}" cy="{-0.5 * $yInterval}" r="5"/>
        <!-- text for project name -->
        <text id="warrenLettersTitle" x="{15+$lineX}" y="{-0.5 * $yInterval + 6}" font-size="22px">
          <xsl:value-of select="$projectNameArray[$index]"/>
        </text>
        <!-- text for date information: count, earliest, latest -->
        <g class="timelineInfo">
          <text x="{15+$lineX}" y="{$yInterval}">Count: <xsl:value-of select="$warrenDateCount"
            /></text>
          <text x="{15+$lineX}" y="{$yInterval * 2}"> Earlist: <xsl:value-of
              select="$warrenOrdered[1]/descendant::date/@when"/>
          </text>
          <text x="{15+$lineX}" y="{$yInterval * 3}"> Latest: <xsl:value-of
              select="$warrenOrdered[last()]/descendant::date/@when"/></text>
        </g>
        <!-- list of MM-DD -->
        <g class="timeline">
          <xsl:for-each select="$warrenOrdered">
            <text x="{20+$lineX}" y="{$yInterval*position()}">
              <xsl:value-of select="current()/descendant::date/@when ! substring(., 6, 10)"/>
            </text>
            <line x1="{$lineX}" y1="{$yInterval*(position()-1.5)}" x2="{$lineX}"
              y2="{$yInterval*(position()+1)}" style="stroke:{$colorArray[$index]};stroke-width:3"/>
            <line x1="{$lineX}" y1="{$yInterval*position()}" x2="{$lineX + 10}"
              y2="{$yInterval*position()}" style="stroke:{$colorArray[$index]};stroke-width:2"
              transform="translate(0,-4)"/>
          </xsl:for-each>
        </g>
      </g>
    </g>

    <!-- timeline for siple -->
    <g id="sipleLetter" transform="translate({50 + 2 * $xInterval}, {$yInterval*4})">
      <xsl:variable name="index" as="xs:integer" select="3"/>
      <g fill="{$colorArray[$index]}">
        <circle cx="{$lineX}" cy="{-0.5 * $yInterval}" r="5"/>
        <!-- text for project name -->
        <text id="sipleLetterTitle" x="{15+$lineX}" y="{-0.5 * $yInterval + 6}" font-size="22px">
          <xsl:value-of select="$projectNameArray[$index]"/>
        </text>
        <!-- text for date information: count, earliest, latest -->
        <g class="timelineInfo">
          <text x="{15+$lineX}" y="{$yInterval}">Count: <xsl:value-of select="$sipleDateCount"
            /></text>
          <text x="{15+$lineX}" y="{$yInterval * 2}">Date: <xsl:value-of
              select="($siple[1]//@when)[1]"/></text>
        </g>
        <!-- list of MM-DD -->
        <g class="timeline">
          <xsl:for-each select="$siple">
            <xsl:sort select="current()/descendant::date/@when" order="ascending"/>
            <text x="{20+$lineX}" y="{$yInterval*position()}">
              <xsl:value-of select="current()/descendant::date/@when ! substring(., 6, 10)"/>
            </text>
            <line x1="{$lineX}" y1="{$yInterval*(position()-1.5)}" x2="{$lineX}"
              y2="{$yInterval*(position()+1)}" style="stroke:{$colorArray[$index]};stroke-width:3"/>
            <line x1="{$lineX}" y1="{$yInterval*position()}" x2="{$lineX + 10}"
              y2="{$yInterval*position()}" style="stroke:{$colorArray[$index]};stroke-width:2"
              transform="translate(0,-4)"/>
          </xsl:for-each>
        </g>
      </g>
    </g>

    <!-- timeline for travel -->
    <g id="travelLetters" transform="translate({50 + 3 * $xInterval}, {$yInterval*4})">
      <xsl:variable name="index" as="xs:integer" select="4"/>
      <g fill="{$colorArray[$index]}">
        <circle cx="{$lineX}" cy="{-0.5 * $yInterval}" r="5"/>
        <!-- text for project name -->
        <text id="travelLettersTitle" x="{15+$lineX}" y="{-0.5 * $yInterval + 6}" font-size="22px">
          <xsl:value-of select="$projectNameArray[$index]"/>
        </text>
        <!-- text for date information: count, earliest, latest -->
        <g class="timelineInfo">
          <text x="{15+$lineX}" y="{$yInterval}">Count: <xsl:value-of select="$travelDateCount"
            /></text>
          <text x="{15+$lineX}" y="{$yInterval * 2}"> Earlist: <xsl:value-of
              select="$travelOrdered[1]/descendant::date/@when"/>
          </text>
          <text x="{15+$lineX}" y="{$yInterval * 3}"> Latest: <xsl:value-of
              select="$travelOrdered[last()]/descendant::date/@when"/></text>
        </g>
        <!-- list of MM-DD -->
        <g class="timeline">
          <xsl:for-each select="$travel">
            <xsl:sort select="current()/descendant::date/@when" order="ascending"/>
            <text x="{20+$lineX}" y="{$yInterval*position()}">
              <xsl:value-of select="current()/descendant::date/@when ! substring(., 6, 10)"/>
            </text>
            <line x1="{$lineX}" y1="{$yInterval*(position()-1.5)}" x2="{$lineX}"
              y2="{$yInterval*(position()+1)}" style="stroke:{$colorArray[$index]};stroke-width:3"/>
            <line x1="{$lineX}" y1="{$yInterval*position()}" x2="{$lineX + 10}"
              y2="{$yInterval*position()}" style="stroke:{$colorArray[$index]};stroke-width:2"
              transform="translate(0,-4)"/>
          </xsl:for-each>
        </g>
      </g>
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
                  <tables>
            <h1>Table for number of different classes in each site</h1>
            <div class="tables">
              <xsl:sequence select="yxj:tableMaker()"/>
            </div>
          </tables>
        <br/>
        <!--<h1>Timeline</h1>
        <div id="svgTimeline">
          <svg xmlns="http://www.w3.org/2000/svg" height="2000px" width="929px">
            <xsl:sequence select="yxj:timeline()"/>
          </svg>
        </div>-->
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
