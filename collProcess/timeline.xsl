<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:yxj="http://www.yxj5181.com" version="3.0"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:output method="xhtml" html-version="5" include-content-type="no" indent="yes"/>

  <!-- variables -->
  <xsl:variable name="xInterval" select="211"/>
  <xsl:variable name="yInterval" select="20"/>
  <xsl:variable name="colorArray" select="'#0080B1', '#41ACA0', '#8A8D0B', '#80B022'"
    as="xs:string+"/>

  <xsl:variable name="calendar" as="document-node()+"
    select="collection('../calendar/tei/?select=*.xml')"/>
  <xsl:variable name="warren" as="document-node()+"
    select="collection('../warrenLetters/XML/fullText/?select=*.xml')"/>
  <xsl:variable name="siple" as="document-node()+"
    select="collection('../sipleLetter/docs/xml?select=lettertefft.xml')"/>
  <xsl:variable name="travel" as="document-node()+"
    select="collection('../behrendTravelLetters/xml-letters?select=*.xml')"/>
  <xsl:variable name="Coll" as="document-node()+" select="$warren | $siple | $travel"/>

  <xsl:variable name="calendarDateList" as="xs:string+">
    <xsl:for-each select="$calendar/descendant::date[@when]"
      xpath-default-namespace="http://www.tei-c.org/ns/1.0">
      <xsl:value-of select="@when"/>
    </xsl:for-each>
  </xsl:variable>

  <xsl:variable name="calendarDateOrdered" as="xs:date+">
    <xsl:for-each select="$calendarDateList">
      <xsl:sort select="current()" order="ascending"/>
      <xsl:value-of select="current()"/>
    </xsl:for-each>
  </xsl:variable>

  <xsl:variable name="warrenDateOrdered" as="xs:date+">
    <xsl:for-each select="$warren/descendant::date[2]/@when">
      <xsl:sort select="current()" order="ascending"/>
      <xsl:value-of select="current()"/>
    </xsl:for-each>
  </xsl:variable>

  <xsl:variable name="travelDateOrdered" as="xs:date+">
    <xsl:for-each select="$travel/descendant::date/@when => distinct-values()">
      <xsl:sort select="current()" order="ascending"/>
      <xsl:value-of select="current()"/>
    </xsl:for-each>
  </xsl:variable>

  <xsl:variable name="projectNameArray" as="xs:string+"
    select="'Calendar', 'Warren Letters', 'Siple Letter', 'Travel Letters'"/>
  <xsl:variable name="yearArray" as="xs:string+" select="'1909', '1929', '1935', '1955'"/>

  <xsl:variable name="calendarDateCount" as="xs:integer" select="$calendarDateList => count()"/>
  <xsl:variable name="warrenDateCount" as="xs:integer" select="$warren => count()"/>
  <xsl:variable name="sipleDateCount" as="xs:integer" select="$siple => count()"/>
  <xsl:variable name="travelDateCount" as="xs:integer" select="$travel => count()"/>

  <xsl:variable name="lineX" select="5"/>

  <xsl:function name="yxj:timeline">
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
            select="$calendarDateList[1]"/></text>
        <text x="{15+$lineX}" y="{$yInterval * 2}">Earlist: <xsl:value-of
            select="$calendarDateOrdered[1]"/></text>
        <text x="{15+$lineX}" y="{$yInterval * 3}">Latest: <xsl:value-of
            select="$calendarDateOrdered[last()]"/></text>
      </g>

      <!-- list of MM-DD -->
      <g class="timeline" transform="translate(0, {$yInterval})">
         <line x1="{$lineX}" y1="{$yInterval * -1.5}" x2="{$lineX}"
                y2="0" stroke-width="3"
                stroke="{$colorArray[1]}"/>
 
        <xsl:variable name="largestDayInterval" as="xs:integer" select="3"/>
        <xsl:for-each select="$calendarDateOrdered"
          xpath-default-namespace="http://www.tei-c.org/ns/1.0">
          <xsl:variable name="pos" as="xs:integer" select="position()"/>
          <xsl:variable name="dayIntervalFromFirst"
            select="days-from-duration(current() - xs:date($calendarDateOrdered[1]))"/>

          <!-- This variable is a list. It is to reduce the interval between dates if the day interval is too large. 
          If the day interval > 3, which means the distance between two dates will be at least 80 px, 
          a gap symbol with 80 px will replace the too large interval here. 
          -->
          <xsl:variable name="dayIntervalFromPreviousFixedList" as="xs:integer+">
            <xsl:for-each select="$calendarDateOrdered">
              <xsl:variable name="pos" select="position()"/>
              <xsl:choose>
                <xsl:when test="position() != 1">
                  <xsl:variable name="dayIntervalFromPrevious" as="xs:integer"
                    select="days-from-duration(current() - $calendarDateOrdered[$pos - 1])"/>
                  <xsl:choose>
                    <xsl:when test="$dayIntervalFromPrevious &gt; $largestDayInterval">
                      <!-- If the day interval between current date and previous date is more than 3 days. -->
                      <xsl:value-of select="$largestDayInterval + 1"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$dayIntervalFromPrevious"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                  <!-- when position = 1 -->
                  <!-- The day interval between first date and previous date is 0. -->
                  <xsl:value-of select="0"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </xsl:variable>

          <!-- This variable is to store elements in $dayIntervalFromPreviousFixedList with index that 1 to current position(). -->
          <xsl:variable name="dayIntervalBuffer" as="xs:integer+">
            <!-- The variable $pos is necessary for for-each here, because if using position() directly, xml editor will get confused. -->
            <xsl:for-each select="1 to $pos">
              <xsl:variable name="index" as="xs:integer" select="position()"/>
              <xsl:choose>
                <xsl:when test="$dayIntervalFromPreviousFixedList[$index] &gt; $largestDayInterval">
                  <xsl:value-of select="2"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$dayIntervalFromPreviousFixedList[$index]"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </xsl:variable>

          <xsl:variable name="dayIntervalFromFirstFixed" as="xs:integer">
            <xsl:value-of select="$dayIntervalBuffer => sum()"/>
          </xsl:variable>

          <!-- print MM-DD -->
          <a href="../docs/calendar/{($calendar//div2/@xml:id => sort(xs:string(.)))[$pos]}.html">
            <text x="{20+$lineX}" y="{$yInterval * $dayIntervalFromFirstFixed}"
              fill="{$colorArray[1]}">
              <xsl:value-of select="current() ! string() ! substring(., 6, 10)"/>
            </text>
          </a>
          <line x1="{$lineX}" y1="{$yInterval * $dayIntervalFromFirstFixed}" x2="{$lineX + 10}"
            y2="{$yInterval * $dayIntervalFromFirstFixed}" stroke-width="2"
            transform="translate(0,-4)" stroke="{$colorArray[1]}"/>

          <!-- line and gap symbol -->
          <xsl:choose>
            <xsl:when test="$dayIntervalFromPreviousFixedList[$pos] &gt; $largestDayInterval">
              <line x1="{$lineX}" y1="{$yInterval * ($dayIntervalFromFirstFixed - 1)}" x2="{$lineX}"
                y2="{$yInterval*($dayIntervalFromFirstFixed) + 0.2}" stroke-width="3"
                stroke="{$colorArray[1]}"/>
              <!-- <line x1="{$lineX}" y1="{$yInterval * ($dayIntervalFromFirstFixed)}" x2="{$lineX}"
                y2="{$yInterval*($dayIntervalFromFirstFixed + 1)}" stroke-width="3"
                stroke="{$colorArray[1]}"/>-->
              <path
                transform="translate(-3, {$yInterval * ($dayIntervalFromFirstFixed - $largestDayInterval + 0.8)})"
                d="M8 1.5V10.5L3.5 15L9.5 17.5L3.5 23.5L10 26L8 30V41.5" stroke="{$colorArray[1]}"
                stroke-width="3" stroke-linecap="round"/>
            </xsl:when>
            <xsl:otherwise>
              <line x1="{$lineX}"
                y1="{$yInterval * ($dayIntervalFromFirstFixed - $dayIntervalFromPreviousFixedList[$pos])}"
                x2="{$lineX}" y2="{$yInterval* $dayIntervalFromFirstFixed}" stroke-width="3"
                stroke="{$colorArray[1]}"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:if test="$pos = last()">
            <line x1="{$lineX}"
              y1="{$yInterval * ($dayIntervalFromFirstFixed - $dayIntervalFromPreviousFixedList[$pos])}"
              x2="{$lineX}" y2="{$yInterval* ($dayIntervalFromFirstFixed + 1.5)}" stroke-width="3"
              stroke="{$colorArray[1]}"/>
          </xsl:if>
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
              select="$warrenDateOrdered[1]"/>
          </text>
          <text x="{15+$lineX}" y="{$yInterval * 3}"> Latest: <xsl:value-of
              select="$warrenDateOrdered[last()]"/></text>
        </g>
        <!-- list of MM-DD -->
        <g class="timeline" transform="translate(0, {$yInterval})">
          <xsl:for-each select="$warrenDateOrdered => distinct-values()">
            <xsl:variable name="daysNumFromFirst"
              select="days-from-duration(xs:date(current()) - $warrenDateOrdered[1])"/>
            <a href="../docs/warrenLettersPage.html">
              <text x="{20+$lineX}" y="{$yInterval*$daysNumFromFirst}" fill="{$colorArray[$index]}">
                <xsl:value-of select="current()"/> (2 letters) </text>
            </a>
            <line x1="{$lineX}" y1="{$yInterval*($daysNumFromFirst - 1.5)}" x2="{$lineX}"
              y2="{$yInterval*($daysNumFromFirst+1)}"
              style="stroke:{$colorArray[$index]};stroke-width:3"/>
            <line x1="{$lineX}" y1="{$yInterval*$daysNumFromFirst}" x2="{$lineX + 10}"
              y2="{$yInterval*$daysNumFromFirst}"
              style="stroke:{$colorArray[$index]};stroke-width:2" transform="translate(0,-4)"/>
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
          <text x="{15+$lineX}" y="{$yInterval}"> Count: <xsl:value-of select="$sipleDateCount"/>
          </text>
          <text x="{15+$lineX}" y="{$yInterval * 2}"> Date: <xsl:value-of
              select="($siple[1]//@when)[1]"/>
          </text>
        </g>
        <!-- list of MM-DD -->
        <g class="timeline">
          <xsl:for-each select="$siple">
            <a href="../docs/siple/{current()/descendant::date[1]/@when}.html">
              <text x="{20+$lineX}" y="{$yInterval*position()}">
                <xsl:value-of select="current()/descendant::date[1]/@when ! substring(., 6, 10)"/>
              </text>
            </a>
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
              select="$travelDateOrdered[1]"/>
          </text>
          <text x="{15+$lineX}" y="{$yInterval * 3}"> Latest: <xsl:value-of
              select="$travelDateOrdered[last()]"/></text>
        </g>
        <!-- list of MM-DD -->
        <g class="timeline" transform="translate(0, {$yInterval})">
          <xsl:for-each select="$travel">
            <xsl:sort select="descendant::date/@when"/>
            <xsl:variable name="currentDate" select="descendant::date[1]/@when" as="xs:date"/>
            <xsl:variable name="pos" select="position()"/>
            <xsl:variable name="daysNumFromFirst"
              select="days-from-duration($currentDate - $travelDateOrdered[1])"/>
            <a href="../docs/travelLetters/{descendant::letter/@xml:id}.html">
              <text x="{20+$lineX}" y="{$yInterval*$daysNumFromFirst}" fill="{$colorArray[$index]}">
                <xsl:value-of select="$currentDate ! string() ! substring(., 6, 10)"/>
              </text>
            </a>
            <line x1="{$lineX}" y1="{$yInterval*$daysNumFromFirst}" x2="{$lineX + 10}"
              y2="{$yInterval*$daysNumFromFirst}"
              style="stroke:{$colorArray[$index]};stroke-width:2" transform="translate(0,-4)"/>
          </xsl:for-each>
          <line x1="{$lineX}" y1="{$yInterval*(-1.5)}" x2="{$lineX}"
            y2="{$yInterval*(days-from-duration($travelDateOrdered[last()] - $travelDateOrdered[1])) + $yInterval}"
            style="stroke:{$colorArray[$index]};stroke-width:3"/>
        </g>
      </g>
    </g>
  </xsl:function>

  <xsl:template match="/">
    <xsl:result-document method="xhtml" html-version="5" omit-xml-declaration="yes"
      include-content-type="no" indent="yes" href="timeline.html">
      <html>
        <head>
          <title>Timeline</title>
          <link rel="stylesheet" type="text/css" href="timeline.css"/>
          <script type="text/javascript" src="interact.js"/>
        </head>
        <body>
          <div id="svgTimeline">
            <svg xmlns="http://www.w3.org/2000/svg" height="1400px" width="930px">
              <xsl:sequence select="yxj:timeline()"/>
            </svg>
          </div>
        </body>
      </html>
    </xsl:result-document>
  </xsl:template>
</xsl:stylesheet>
