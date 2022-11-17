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
    <xsl:variable name="siple" as="document-node()+"
      select="collection('input/sipleLetter/?select=*.xml')"/>
    <xsl:variable name="travel" as="document-node()+"
      select="collection('input/travelLetters/?select=*.xml')"/>
    <xsl:variable name="warren" as="document-node()+"
      select="collection('input/warrenLetters/?select=*.xml')"/>
    <xsl:variable name="Coll" as="document-node()+" select="$warren, $siple, $travel"/>

    <xsl:variable name="canlendarDateCountList" as="xs:integer+">
      <xsl:for-each select="$canlendar" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
        <xsl:value-of select="current()//descendant::date[@when] => count()"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="canlendarDateTotalNum" as="xs:integer" select="sum($canlendarDateCountList)"/>

    <xsl:variable name="warrenDateCountList" as="xs:integer+">
      <xsl:for-each select="$warren">
        <xsl:value-of select="current() => count()"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="warrenDateTotalNum" as="xs:integer" select="sum($warrenDateCountList)"/>

    <xsl:variable name="sipleDateCountList" as="xs:integer+">
      <xsl:for-each select="$siple">
        <xsl:value-of select="current()//descendant::date[@when] => count()"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="sipleDateTotalNum" as="xs:integer" select="sum($sipleDateCountList)"/>
    
    <xsl:variable name="moveUpUnit" as="xs:integer+" select="0, 0, $warrenDateTotalNum, $sipleDateTotalNum + $warrenDateTotalNum"/>
    


    <xsl:variable name="lineX" select="5"/>
    <!-- timeline for canlendar -->
    <g transform="translate(50, {$yInterval div 2})" fill="{$colorArray[1]}">
      <circle cx="{$lineX}" cy="0" r="5" fill="{$colorArray[1]}"/>
      <xsl:for-each select="$canlendar/descendant::date/@when"
        xpath-default-namespace="http://www.tei-c.org/ns/1.0">
        <xsl:sort select="current()" order="ascending"/>
        <text x="{20+$lineX}" y="{$yInterval*position()}">
          <xsl:value-of select="current() ! substring(., 6, 10)"/>
        </text>
        <line x1="{$lineX}" y1="{$yInterval*(position()-1)}" x2="{$lineX}"
          y2="{$yInterval*position()}" style="stroke:{$colorArray[1]};stroke-width:3"/>
      </xsl:for-each>
    </g>


    <xsl:variable name="filenameArray" select="$Coll ! base-uri() ! tokenize(., '/')[last() - 1]"
      as="xs:string+"/>
    <!-- timeline for warren, siple, and travel letters -->
      <g transform="translate(50, {0.5*$yInterval})">

        <xsl:for-each select="$Coll">
          <xsl:sort select="current()/descendant::date/@when" order="ascending"/>
          <xsl:variable name="currentLetter"
            select="current() ! base-uri() ! tokenize(., '/')[last() - 1]"/>
          <xsl:variable name="index" as="xs:integer">
            <xsl:choose>
              <xsl:when test="$currentLetter = 'warrenLetters'">
                <xsl:value-of select="2"/>
              </xsl:when>
              <xsl:when test="$currentLetter = 'sipleLetter'">
                <xsl:value-of select="3"/>
              </xsl:when>
              <xsl:when test="$currentLetter = 'travelLetters'">
                <xsl:value-of select="4"/>
              </xsl:when>
            </xsl:choose>
          </xsl:variable>
          
          
          <g class="{$currentLetter}" fill="{$colorArray[$index]}"
            transform="translate({($index - 1)*$xInterval}, {-$moveUpUnit[$index]*$yInterval})">
            <circle cx="{$lineX}" cy="{$moveUpUnit[$index]*$yInterval}" r="5" fill="{$colorArray[$index]}"/>
            
            <text x="{20+$lineX}" y="{$yInterval*position()}">
              <xsl:value-of select="current()/descendant::date/@when ! substring(., 6, 10)"/>
            </text>
            <line x1="{$lineX}" y1="{$yInterval*(position()-1)}" x2="{$lineX}"
              y2="{$yInterval*position()}" style="stroke:{$colorArray[$index]};stroke-width:3"/>
          </g>
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
        <svg width="929" height="51" viewBox="0 0 929 51" fill="none"
          xmlns="http://www.w3.org/2000/svg">
          <path d="M881 30H918.238L929 40.5L918.238 51H881V30Z" fill="#B1B1B1"/>
          <path d="M670 30H885.238L896 40.5L885.238 51H670V30Z" fill="#80B022"/>
          <path
            d="M740.712 4.304L740.424 2.928L746.792 0.495998H747.464V16.08L750.856 15.824L750.952 18H740.968L741.032 16.592L744.648 16.336L745 11.664V3.536L740.712 4.304ZM755.132 7.248C755.132 5.41333 755.74 3.83467 756.956 2.512C758.172 1.168 759.772 0.495998 761.756 0.495998C763.761 0.495998 765.361 1.264 766.556 2.8C767.751 4.31467 768.348 6.43733 768.348 9.168C768.348 13.072 767.345 16.1227 765.34 18.32C763.335 20.5387 760.433 21.776 756.636 22.032L756.508 20.144C759.687 19.824 761.969 18.8533 763.356 17.232C764.764 15.5893 765.468 13.072 765.468 9.68C765.468 7.184 765.137 5.38133 764.476 4.272C763.836 3.14133 762.801 2.576 761.372 2.576C760.412 2.576 759.548 2.81067 758.78 3.28C758.268 4.048 758.012 5.22133 758.012 6.8C758.012 8.37867 758.332 9.52 758.972 10.224C759.633 10.9067 760.647 11.248 762.012 11.248C762.353 11.248 762.919 11.1947 763.708 11.088L763.868 12.24L760.444 13.104C758.887 13.104 757.607 12.5813 756.604 11.536C755.623 10.4907 755.132 9.06133 755.132 7.248ZM773.296 9.808L773.648 0.655998H778.896L782.768 0.143999L782.512 2.8H775.728L775.536 8.048H776.048C778.416 8.048 780.261 8.56 781.584 9.584C782.928 10.5867 783.6 11.9947 783.6 13.808C783.6 16.1547 782.608 18.032 780.624 19.44C778.661 20.848 775.973 21.6053 772.56 21.712L772.432 19.824C775.099 19.632 777.136 19.0453 778.544 18.064C779.952 17.0827 780.656 15.8027 780.656 14.224C780.656 12.624 780.229 11.472 779.376 10.768C778.523 10.064 777.2 9.712 775.408 9.712C774.704 9.712 774 9.744 773.296 9.808ZM789.796 9.808L790.148 0.655998H795.396L799.268 0.143999L799.012 2.8H792.228L792.036 8.048H792.548C794.916 8.048 796.761 8.56 798.084 9.584C799.428 10.5867 800.1 11.9947 800.1 13.808C800.1 16.1547 799.108 18.032 797.124 19.44C795.161 20.848 792.473 21.6053 789.06 21.712L788.932 19.824C791.599 19.632 793.636 19.0453 795.044 18.064C796.452 17.0827 797.156 15.8027 797.156 14.224C797.156 12.624 796.729 11.472 795.876 10.768C795.023 10.064 793.7 9.712 791.908 9.712C791.204 9.712 790.5 9.744 789.796 9.808Z"
            fill="#80B022"/>
          <path d="M770.5 45L763.139 36H777.861L770.5 45Z" fill="#D9D9D9"/>
          <path d="M459 30H670.5L681.262 40.5L670.5 51H459V30Z" fill="#8A8D0B"/>
          <path
            d="M529.712 4.304L529.424 2.928L535.792 0.495998H536.464V16.08L539.856 15.824L539.952 18H529.968L530.032 16.592L533.648 16.336L534 11.664V3.536L529.712 4.304ZM544.132 7.248C544.132 5.41333 544.74 3.83467 545.956 2.512C547.172 1.168 548.772 0.495998 550.756 0.495998C552.761 0.495998 554.361 1.264 555.556 2.8C556.751 4.31467 557.348 6.43733 557.348 9.168C557.348 13.072 556.345 16.1227 554.34 18.32C552.335 20.5387 549.433 21.776 545.636 22.032L545.508 20.144C548.687 19.824 550.969 18.8533 552.356 17.232C553.764 15.5893 554.468 13.072 554.468 9.68C554.468 7.184 554.137 5.38133 553.476 4.272C552.836 3.14133 551.801 2.576 550.372 2.576C549.412 2.576 548.548 2.81067 547.78 3.28C547.268 4.048 547.012 5.22133 547.012 6.8C547.012 8.37867 547.332 9.52 547.972 10.224C548.633 10.9067 549.647 11.248 551.012 11.248C551.353 11.248 551.919 11.1947 552.708 11.088L552.868 12.24L549.444 13.104C547.887 13.104 546.607 12.5813 545.604 11.536C544.623 10.4907 544.132 9.06133 544.132 7.248ZM561.272 22.032L561.144 20.176C563.747 20.0053 565.763 19.4293 567.192 18.448C568.643 17.4667 569.368 16.1867 569.368 14.608C569.368 13.3493 568.931 12.4427 568.056 11.888C567.181 11.312 565.688 10.9707 563.576 10.864L563.416 9.072C567.128 8.51733 568.984 7.20533 568.984 5.136C568.984 3.42933 567.832 2.576 565.528 2.576L561.944 3.952L561.048 1.488C562.477 0.826665 564.109 0.495998 565.944 0.495998C567.8 0.495998 569.24 0.858665 570.264 1.584C571.288 2.30933 571.8 3.26933 571.8 4.464C571.8 5.65867 571.405 6.704 570.616 7.6C569.827 8.47467 568.696 9.168 567.224 9.68C568.76 9.78667 569.987 10.32 570.904 11.28C571.843 12.2187 572.312 13.4133 572.312 14.864C572.312 16.8907 571.267 18.576 569.176 19.92C567.107 21.2853 564.472 21.9893 561.272 22.032ZM578.796 9.808L579.148 0.655998H584.396L588.268 0.143999L588.012 2.8H581.228L581.036 8.048H581.548C583.916 8.048 585.761 8.56 587.084 9.584C588.428 10.5867 589.1 11.9947 589.1 13.808C589.1 16.1547 588.108 18.032 586.124 19.44C584.161 20.848 581.473 21.6053 578.06 21.712L577.932 19.824C580.599 19.632 582.636 19.0453 584.044 18.064C585.452 17.0827 586.156 15.8027 586.156 14.224C586.156 12.624 585.729 11.472 584.876 10.768C584.023 10.064 582.7 9.712 580.908 9.712C580.204 9.712 579.5 9.744 578.796 9.808Z"
            fill="#8A8D0B"/>
          <path d="M559.5 45L552.139 36H566.861L559.5 45Z" fill="#D9D9D9"/>
          <path d="M248 30H459L469.762 40.5L459 51H248V30Z" fill="#41ACA0"/>
          <path
            d="M318.712 4.304L318.424 2.928L324.792 0.495998H325.464V16.08L328.856 15.824L328.952 18H318.968L319.032 16.592L322.648 16.336L323 11.664V3.536L318.712 4.304ZM333.132 7.248C333.132 5.41333 333.74 3.83467 334.956 2.512C336.172 1.168 337.772 0.495998 339.756 0.495998C341.761 0.495998 343.361 1.264 344.556 2.8C345.751 4.31467 346.348 6.43733 346.348 9.168C346.348 13.072 345.345 16.1227 343.34 18.32C341.335 20.5387 338.433 21.776 334.636 22.032L334.508 20.144C337.687 19.824 339.969 18.8533 341.356 17.232C342.764 15.5893 343.468 13.072 343.468 9.68C343.468 7.184 343.137 5.38133 342.476 4.272C341.836 3.14133 340.801 2.576 339.372 2.576C338.412 2.576 337.548 2.81067 336.78 3.28C336.268 4.048 336.012 5.22133 336.012 6.8C336.012 8.37867 336.332 9.52 336.972 10.224C337.633 10.9067 338.647 11.248 340.012 11.248C340.353 11.248 340.919 11.1947 341.708 11.088L341.868 12.24L338.444 13.104C336.887 13.104 335.607 12.5813 334.604 11.536C333.623 10.4907 333.132 9.06133 333.132 7.248ZM350.528 18L350.176 16.816C353.909 12.9973 356.288 10.256 357.312 8.592C357.973 7.52533 358.304 6.512 358.304 5.552C358.304 4.592 358.037 3.856 357.504 3.344C356.971 2.832 356.149 2.576 355.04 2.576C353.952 2.576 352.747 2.88533 351.424 3.504L350.72 1.616C352.256 0.869332 353.931 0.495998 355.744 0.495998C357.557 0.495998 358.933 0.911999 359.872 1.744C360.832 2.576 361.312 3.71733 361.312 5.168C361.312 6.59733 360.832 7.96267 359.872 9.264C358.933 10.5653 356.768 12.7307 353.376 15.76H358.56L362.432 15.248L362.176 18H350.528ZM366.132 7.248C366.132 5.41333 366.74 3.83467 367.956 2.512C369.172 1.168 370.772 0.495998 372.756 0.495998C374.761 0.495998 376.361 1.264 377.556 2.8C378.751 4.31467 379.348 6.43733 379.348 9.168C379.348 13.072 378.345 16.1227 376.34 18.32C374.335 20.5387 371.433 21.776 367.636 22.032L367.508 20.144C370.687 19.824 372.969 18.8533 374.356 17.232C375.764 15.5893 376.468 13.072 376.468 9.68C376.468 7.184 376.137 5.38133 375.476 4.272C374.836 3.14133 373.801 2.576 372.372 2.576C371.412 2.576 370.548 2.81067 369.78 3.28C369.268 4.048 369.012 5.22133 369.012 6.8C369.012 8.37867 369.332 9.52 369.972 10.224C370.633 10.9067 371.647 11.248 373.012 11.248C373.353 11.248 373.919 11.1947 374.708 11.088L374.868 12.24L371.444 13.104C369.887 13.104 368.607 12.5813 367.604 11.536C366.623 10.4907 366.132 9.06133 366.132 7.248Z"
            fill="#41ACA0"/>
          <path d="M348.5 45L341.139 36H355.861L348.5 45Z" fill="#D9D9D9"/>
          <path d="M37 30H248.5L259.262 40.5L248.5 51H37V30Z" fill="#0080B1"/>
          <path
            d="M107.712 4.304L107.424 2.928L113.792 0.495998H114.464V16.08L117.856 15.824L117.952 18H107.968L108.032 16.592L111.648 16.336L112 11.664V3.536L107.712 4.304ZM122.132 7.248C122.132 5.41333 122.74 3.83467 123.956 2.512C125.172 1.168 126.772 0.495998 128.756 0.495998C130.761 0.495998 132.361 1.264 133.556 2.8C134.751 4.31467 135.348 6.43733 135.348 9.168C135.348 13.072 134.345 16.1227 132.34 18.32C130.335 20.5387 127.433 21.776 123.636 22.032L123.508 20.144C126.687 19.824 128.969 18.8533 130.356 17.232C131.764 15.5893 132.468 13.072 132.468 9.68C132.468 7.184 132.137 5.38133 131.476 4.272C130.836 3.14133 129.801 2.576 128.372 2.576C127.412 2.576 126.548 2.81067 125.78 3.28C125.268 4.048 125.012 5.22133 125.012 6.8C125.012 8.37867 125.332 9.52 125.972 10.224C126.633 10.9067 127.647 11.248 129.012 11.248C129.353 11.248 129.919 11.1947 130.708 11.088L130.868 12.24L127.444 13.104C125.887 13.104 124.607 12.5813 123.604 11.536C122.623 10.4907 122.132 9.06133 122.132 7.248ZM145.192 18.48C142.888 18.48 141.128 17.6587 139.912 16.016C138.696 14.352 138.088 12.208 138.088 9.584C138.088 6.93867 138.707 4.76267 139.944 3.056C141.203 1.34933 142.984 0.495998 145.288 0.495998C147.613 0.495998 149.384 1.328 150.6 2.992C151.816 4.656 152.424 6.8 152.424 9.424C152.424 12.048 151.795 14.2133 150.536 15.92C149.277 17.6267 147.496 18.48 145.192 18.48ZM145.288 2.608C143.816 2.608 142.685 3.25867 141.896 4.56C141.128 5.84 140.744 7.504 140.744 9.552C140.744 11.6 141.117 13.2533 141.864 14.512C142.611 15.7493 143.72 16.368 145.192 16.368C146.685 16.368 147.816 15.728 148.584 14.448C149.373 13.168 149.768 11.4933 149.768 9.424C149.768 7.35467 149.395 5.70133 148.648 4.464C147.901 3.22667 146.781 2.608 145.288 2.608ZM155.132 7.248C155.132 5.41333 155.74 3.83467 156.956 2.512C158.172 1.168 159.772 0.495998 161.756 0.495998C163.761 0.495998 165.361 1.264 166.556 2.8C167.751 4.31467 168.348 6.43733 168.348 9.168C168.348 13.072 167.345 16.1227 165.34 18.32C163.335 20.5387 160.433 21.776 156.636 22.032L156.508 20.144C159.687 19.824 161.969 18.8533 163.356 17.232C164.764 15.5893 165.468 13.072 165.468 9.68C165.468 7.184 165.137 5.38133 164.476 4.272C163.836 3.14133 162.801 2.576 161.372 2.576C160.412 2.576 159.548 2.81067 158.78 3.28C158.268 4.048 158.012 5.22133 158.012 6.8C158.012 8.37867 158.332 9.52 158.972 10.224C159.633 10.9067 160.647 11.248 162.012 11.248C162.353 11.248 162.919 11.1947 163.708 11.088L163.868 12.24L160.444 13.104C158.887 13.104 157.607 12.5813 156.604 11.536C155.623 10.4907 155.132 9.06133 155.132 7.248Z"
            fill="#0080B1"/>
          <path d="M137.5 45L130.139 36H144.861L137.5 45Z" fill="#D9D9D9"/>
          <path d="M0 30H37.2381L48 40.5L37.2381 51H0V30Z" fill="#B1B1B1"/>
        </svg>
        <svg xmlns="http://www.w3.org/2000/svg" height="1000px" width="1000px">
          <xsl:sequence select="yxj:timeline()"/>
        </svg>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
