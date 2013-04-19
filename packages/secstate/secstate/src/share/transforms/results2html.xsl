<?xml version="1.0" encoding="UTF-8"?>
<!-- results2html.xsl -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:x="http://checklists.nist.gov/xccdf/1.1"> 

<xsl:output method="html"
    media-type="text/html"
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
    doctype-system="DTD/xhtml1-strict.dtd"
    cdata-section-elements="script style"
    encoding="UTF-8"
    indent="yes"/>

<xsl:param name="path"/>
<xsl:param name="ovalid"/>

<!-- Benchmark result counts -->
<xsl:variable name="ruleResult" select="//*[local-name(.)='rule-result']/*[local-name(.)='result']"/>
<xsl:variable name="numBenchPass" select="count($ruleResult[.='pass'])"/>
<xsl:variable name="numBenchFail" select="count($ruleResult[.='fail'])"/>
<xsl:variable name="numBenchError" select="count($ruleResult[.='error'])"/>
<xsl:variable name="numBenchUnknown" select="count($ruleResult[.='unknown'])"/>
<xsl:variable name="numBenchNotChecked" select="count($ruleResult[.='notchecked'])"/>
<xsl:variable name="numBenchNotApp" select="count($ruleResult[.='notapplicable'])"/>
<xsl:variable name="numBenchNotSelected" select="count($ruleResult[.='notselected'])"/>
<xsl:variable name="numBenchFixed" select="count($ruleResult[.='fixed'])"/>
<xsl:variable name="numBenchMitd" select="count($ruleResult[.='informational'])"/>
<xsl:variable name="numBenchTotal" select="count(//x:rule-result)"/>
<xsl:variable name="numBenchParseError" select="count(//x:rule-result[not(x:result)])"/>
        
<!-- OVAL result counts -->        
<xsl:variable name="defResult" select="//*[local-name(.)='results']//*[local-name(.)='definition']"/>
<xsl:variable name="numOvalTrue" select="count($defResult[@result='true'])"/>
<xsl:variable name="numOvalFalse" select="count($defResult[@result='false'])"/>
<xsl:variable name="numOvalUnknown" select="count($defResult[@result='unknown'])"/>
<xsl:variable name="numOvalError" select="count($defResult[@result='error'])"/>
<xsl:variable name="numOvalNotEval" select="count($defResult[@result='not evaluated'])"/>
<xsl:variable name="numOvalNotApp" select="count($defResult[@result='not applicable'])"/>

<!-- The original file the transform is applied to -->
<xsl:variable name="original" select="/"/>

<!-- Used to obtain general information about the system -->
<xsl:variable name="genOval" select="//*[local-name(.)='check-content-ref']/@href"/>
<xsl:variable name="genOvalRes" select="concat(substring-before($genOval, '.xml'), '.results.xml')"/>

<xsl:template match="/">
<xsl:value-of select="pathname"/>
  <html>
        <head>
            <title>SecState Audit Results</title>
            <link id="style" rel="stylesheet" href="media/css/main.css" type="text/css" media="screen" />
            <link rel="stylesheet" href="media/css/print.css" type="text/css" media="print" />
            <script type="text/javascript" src="media/js/jquery-1.4.2.min.js"></script>
            <script type="text/javascript" src="media/js/custom.js"></script>
       </head>

       <body>
           <div id="wrap">
            <div id="header">
                <span id="secstate">
                    <h1>SecState</h1> Version 1.0<br/>
                    System Security Compliance &amp; Audit Tool
                </span>
                <span id="nav">
                    <!--<div id="logo"></div>-->
                    <a id="help" href="#">Help</a>
                    <a id="about" href="#">About SecState</a>
                    <a id="print" href="#">Print Report</a>
                    <a id="toggle" href="#">Expand All</a>
                    <xsl:choose>
                        <xsl:when test="*[local-name(.)='Index']">
                            <a id="index" class="current" style="color: #C00000" href="index.html"></a>
                        </xsl:when>
                        <xsl:otherwise>
                            <a id="index" href="index.html">Audit Summary</a> 
                        </xsl:otherwise>
                    </xsl:choose>
                </span>
                <div id="info">
                    <xsl:apply-templates select="*[local-name(.)='Index']"/>
                    <xsl:apply-templates select="*[local-name(.)='Benchmark']"/>
                    <xsl:apply-templates select="*[local-name(.)='oval_results']//*[local-name(.)='system_info']"/>
                    <xsl:apply-templates select="//*[local-name(.)='results']"/> 
                    <xsl:apply-templates select="//*[local-name(.)='interfaces']"/>
                    <xsl:if test="$genOval">
                        <xsl:apply-templates select="document(concat($path,$genOvalRes))//*[local-name(.)='interfaces']"/>
                    </xsl:if>
                </div>
           </div>
           <div id="results">
                <ol id="tree">
                    <xsl:apply-templates select="*[local-name(.)='Index']/*[local-name(.)='file']"/>
                    <xsl:apply-templates select="*[local-name(.)='Benchmark']//*[local-name(.)='TestResult']"/>
                    <xsl:apply-templates select="*[local-name(.)='oval_results']"/>
                </ol>
            </div>
           </div>
           <div id="footer"><span id="tresys">Tresys Technology, LLC</span><span id="version">SecState Version 1.0</span></div>
        </body>
    </html>
</xsl:template>

<xsl:template match="*[local-name(.)='Index']">
    <xsl:variable name="file" select="*[local-name(.)='file']"/>
    <xsl:variable name="fileDoc" select="document(concat($path,$file))"/>
    <xsl:choose>
    <xsl:when test="$fileDoc/*[local-name(.)='oval_results']">
        <xsl:apply-templates select="$fileDoc//*[local-name(.)='system_info']"/>
    </xsl:when>
    <xsl:otherwise>
        <xsl:variable name="ovalFile" select="$fileDoc//*[local-name(.)='check-content-ref']/@href"/>
        <xsl:variable name="ovalRes" select="concat(substring-before($ovalFile, '.xml'), '.results.xml')"/>
        <xsl:apply-templates select="document(concat($path,$ovalRes))//*[local-name(.)='system_info']"/>
    </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="*[local-name(.)='file']">
    <xsl:variable name="file" select="."/>
    <xsl:variable name="docFile" select="document(concat($path,$file))"/>
    <xsl:variable name="htmlFile" select="concat(substring-before($file, '.xml'), '.html')"/>
    <xsl:if test="$docFile//*[local-name(.)='Benchmark']">
        <xsl:variable name="ruleResult" select="$docFile//*[local-name(.)='rule-result']/*[local-name(.)='result']"/>
        <xsl:variable name="numBenchPass" select="count($ruleResult[.='pass'])"/>
        <xsl:variable name="numBenchFail" select="count($ruleResult[.='fail'])"/>
        <xsl:variable name="numBenchError" select="count($ruleResult[.='error'])"/>
        <xsl:variable name="numBenchUnknown" select="count($ruleResult[.='unknown'])"/>
        <xsl:variable name="numBenchNotChecked" select="count($ruleResult[.='notchecked'])"/>
        <xsl:variable name="numBenchNotApp" select="count($ruleResult[.='notapplicable'])"/>
        <xsl:variable name="numBenchNotSelected" select="count($ruleResult[.='notselected'])"/>
        <xsl:variable name="numBenchFixed" select="count($ruleResult[.='fixed'])"/>
        <xsl:variable name="numBenchMitd" select="count($ruleResult[.='informational'])"/>
        <!--I am so, so sorry about this hack. We can't get the namespace into this template.
            If you have a fix for this, please let us know. We'd like to do this properly. -->
        <xsl:variable name="numBenchTotal" select="count($docFile//*[local-name(.)='rule-result'])"/>
        <xsl:variable name="numBenchParseError" select="$numBenchTotal - count($ruleResult)"/>

        <li>
            <span class="toggle"></span>
            <a href="{$htmlFile}">
                <span class="title"><xsl:value-of select="$docFile//*[local-name(.)='Benchmark']/@id"/></span>
            </a>
            <span> : Benchmark</span>
            <ol class="hidden">
                <li>
                    <dl class="interface">
                    <dt>Failures: </dt>
                    <dd><xsl:value-of select="$numBenchFail"/></dd>
                    <dt>Mitigations: </dt>
                    <dd><xsl:value-of select="$numBenchMitd"/></dd>
                    <dt>Passes: </dt>
                    <dd><xsl:value-of select="$numBenchPass"/></dd>
                    <dt>Error: </dt>
                    <dd><xsl:value-of select="$numBenchError"/></dd>
                    <dt>Unknown: </dt>
                    <dd><xsl:value-of select="$numBenchUnknown"/></dd>
                    <dt>Not Checked: </dt>
                    <dd><xsl:value-of select="$numBenchNotChecked"/></dd>
                    <dt>Not Applicable: </dt>
                    <dd><xsl:value-of select="$numBenchNotApp"/></dd>
                    <dt>Not Selected: </dt>
                    <dd><xsl:value-of select="$numBenchNotSelected"/></dd>
                    <dt>Fixed: </dt>
                    <dd><xsl:value-of select="$numBenchFixed"/></dd>
                    <dt>Parse Error: </dt>
                    <dd><xsl:value-of select="$numBenchParseError"/></dd>
                    <dt>Total: </dt>
                    <dd><xsl:value-of select="$numBenchTotal"/></dd>
                    <dt>Timestamp: </dt>
                    <xsl:variable name="date" select="substring-before($docFile//*[local-name(.)='TestResult']/@end-time, 'T')"/>
                    <xsl:variable name="time" select="substring-after($docFile//*[local-name(.)='TestResult']/@end-time, 'T')"/>
                    <dd><xsl:value-of select="$date"/> ( <xsl:value-of select="$time"/> ) </dd>
                    </dl>
                </li>
            </ol>
        </li>
    </xsl:if>
    <xsl:if test="$docFile//*[local-name(.)='oval_results']">
        <xsl:variable name="defResult" select="$docFile//*[local-name(.)='results']//*[local-name(.)='definition']"/>
        <xsl:variable name="numOvalTrue" select="count($defResult[@result='true'])"/>
        <xsl:variable name="numOvalFalse" select="count($defResult[@result='false'])"/>
        <xsl:variable name="numOvalUnknown" select="count($defResult[@result='unknown'])"/>
        <xsl:variable name="numOvalError" select="count($defResult[@result='error'])"/>
        <xsl:variable name="numOvalNotEval" select="count($defResult[@result='not evaluated'])"/>
        <xsl:variable name="numOvalNotApp" select="count($defResult[@result='not applicable'])"/>
        <li>
            <span class="toggle"></span>
            <a href="{$htmlFile}">
                <span class="title"><xsl:value-of select="$file"/></span>
            </a>
            <span> : OVAL</span>
            <ol class="hidden">
                <li>
                    <dl class="interface">
                    <dt>Failures: </dt>
                    <dd><xsl:value-of select="$numOvalFalse"/></dd>
                    <dt>Passes: </dt>
                    <dd><xsl:value-of select="$numOvalTrue"/></dd>
                    <dt>Unknown: </dt>
                    <dd><xsl:value-of select="$numOvalUnknown"/></dd>
                    <dt>Error: </dt>
                    <dd><xsl:value-of select="$numOvalError"/></dd>
                    <dt>Not Evaluated: </dt>
                    <dd><xsl:value-of select="$numOvalNotEval"/></dd>
                    <dt>Not Applicable: </dt>
                    <dd><xsl:value-of select="$numOvalNotApp"/></dd>
                    <dt>Timestamp: </dt>
                    <xsl:variable name="date" select="substring-before($docFile//*[local-name(.)='timestamp'], 'T')"/>
                    <xsl:variable name="time" select="substring-after($docFile//*[local-name(.)='timestamp'], 'T')"/>
                    <dd><xsl:value-of select="$date"/> ( <xsl:value-of select="$time"/> ) </dd>
                    </dl>
                </li>
            </ol>
        </li>
    </xsl:if>
</xsl:template>

<xsl:template match="*[local-name(.)='interfaces']">
<dl id="interfaces">
    <span class="toggle title white">Interfaces</span>
    <ol class="hidden">
    <li>
    <xsl:for-each select="*[local-name(.)='interface']">
    <dl class="interface">
        <dt>Interface Name: </dt>
        <dd><xsl:value-of select="*[local-name(.)='interface_name']"/></dd>
        <dt>IP Address: </dt>
        <dd><xsl:value-of select="*[local-name(.)='ip_address']"/></dd>
        <dt>MAC Address: </dt>
        <dd><xsl:value-of select="*[local-name(.)='mac_address']"/></dd>
    </dl>
    </xsl:for-each>
    </li>
    </ol>
</dl>
</xsl:template>

<xsl:template match="*[local-name(.)='Benchmark']">
        <xsl:apply-templates select="document(concat($path,$genOvalRes))//*[local-name(.)='system_info']"/>
        <dl id="benchmark">
            <dt class="title white">Audit Summary</dt>
            <dd>
                <dl class="summary">
                    <xsl:variable name="date" select="substring-before(//*[local-name(.)='TestResult']/@end-time, 'T')"/>
                    <xsl:variable name="time" select="substring-after(//*[local-name(.)='TestResult']/@end-time, 'T')"/>
                    <dt>Benchmark ID: </dt>
                    <dd><xsl:value-of select="@id"/> : <xsl:value-of select="$date"/> ( <xsl:value-of select="$time"/> ) </dd>
                    <dt>Total: </dt>
                    <dd><xsl:value-of select="$numBenchTotal"/></dd>
                    <dt>Failures: </dt>
                    <dd><xsl:value-of select="$numBenchFail"/></dd>
                    <dt>Mitigations: </dt>
                    <dd><xsl:value-of select="$numBenchMitd"/></dd>
                    <dt>Passes: </dt>
                    <dd><xsl:value-of select="$numBenchPass"/></dd>
                    <dt class="toggle">Other</dt>
                    <dd>
                        <xsl:value-of select="$numBenchError + $numBenchUnknown + $numBenchNotChecked + $numBenchNotApp + $numBenchNotSelected + $numBenchFixed + $numBenchParseError"/>
                    </dd>
                        <dl class="hidden summary">
                            <dt>Error: </dt>
                            <dd><xsl:value-of select="$numBenchError"/></dd>
                            <dt>Unknown: </dt>
                            <dd><xsl:value-of select="$numBenchUnknown"/></dd>
                            <dt>Not Checked: </dt>
                            <dd><xsl:value-of select="$numBenchNotChecked"/></dd>
                            <dt>Not Applicable: </dt>
                            <dd><xsl:value-of select="$numBenchNotApp"/></dd>
                            <dt>Not Selected: </dt>
                            <dd><xsl:value-of select="$numBenchNotSelected"/></dd>
                            <dt>Fixed: </dt>
                            <dd><xsl:value-of select="$numBenchFixed"/></dd>
                            <dt>Parse Error: </dt>
                            <dd><xsl:value-of select="$numBenchParseError"/></dd>
                        </dl>
                </dl>
            </dd>
        </dl>
</xsl:template>

<xsl:template match="*[local-name(.)='TestResult']">
    <li>
        <dl class="result toggle">
        <dt class="title">Failures: </dt>
        <dd class="count"><xsl:value-of select="$numBenchFail"/></dd>
        </dl>
        <ol class="hidden">
                <xsl:if test="$numBenchFail &gt; 0">
                    <xsl:apply-templates select="//*[local-name(.)='rule-result']/*[local-name(.)='result'][.='fail']/..">
                        <xsl:with-param name="result" select="'FAILURE'"/>
                    </xsl:apply-templates>
                </xsl:if>
        </ol>
    </li>
    <li>
        <dl class="result toggle">
        <dt class="title">Mitigations: </dt>
        <dd class="count"><xsl:value-of select="$numBenchMitd"/></dd>
        </dl>
        <ol class="hidden">
                <xsl:if test="$numBenchMitd &gt; 0">
                    <xsl:apply-templates select="//*[local-name(.)='rule-result']/*[local-name(.)='result'][.='informational']/..">
                        <xsl:with-param name="result" select="'MITIGATION'"/>
                    </xsl:apply-templates>
                </xsl:if>
        </ol>
    </li>
    <li>
        <dl class="result toggle">
        <dt class="title">Passes: </dt>
        <dd class="count"><xsl:value-of select="$numBenchPass"/></dd>
        </dl>
        <ol class="hidden">
                <xsl:if test="$numBenchPass &gt; 0">
                    <xsl:apply-templates select="//*[local-name(.)='rule-result']/*[local-name(.)='result'][.='pass']/..">
                        <xsl:with-param name="result" select="'PASS'"/>
                    </xsl:apply-templates>
                </xsl:if>
        </ol>
    </li>
    <li>
    <dl class="result toggle">
        <dt class="title">Other: </dt>
        <dd><xsl:value-of select="$numBenchError + $numBenchUnknown + $numBenchNotChecked + $numBenchNotApp + $numBenchNotSelected + $numBenchFixed + $numBenchParseError"/></dd>
    </dl>
    <ol class="hidden other">
    <li>
        <dl class="result toggle">
        <dt class="title">Error: </dt>
        <dd class="count"><xsl:value-of select="$numBenchError"/></dd>
        </dl>
        <ol class="hidden">
                <xsl:if test="$numBenchError &gt; 0">
                    <xsl:apply-templates select="//*[local-name(.)='rule-result']/*[local-name(.)='result'][.='error']/..">
                        <xsl:with-param name="result" select="'ERROR'"/>
                    </xsl:apply-templates>
                </xsl:if>
        </ol>
    </li>
    <li>
        <dl class="result toggle">
        <dt class="title">Unknown: </dt>
        <dd class="count"><xsl:value-of select="$numBenchUnknown"/></dd>
        </dl>
        <ol class="hidden">
                <xsl:if test="$numBenchUnknown &gt; 0">
                    <xsl:apply-templates select="//*[local-name(.)='rule-result']/*[local-name(.)='result'][.='unknown']/..">
                        <xsl:with-param name="result" select="'UNKNOWN'"/>
                    </xsl:apply-templates>
                </xsl:if>
        </ol>
    </li>
    <li>
        <dl class="result toggle">
        <dt class="title">Not Checked: </dt>
        <dd class="count"><xsl:value-of select="$numBenchNotChecked"/></dd>
        </dl>
        <ol class="hidden">
                <xsl:if test="$numBenchNotChecked &gt; 0">
                    <xsl:apply-templates select="//*[local-name(.)='rule-result']/*[local-name(.)='result'][.='notchecked']/..">
                        <xsl:with-param name="result" select="'NOT CHECKED'"/>
                    </xsl:apply-templates>
                </xsl:if>
        </ol>
    </li>
    <li>
        <dl class="result toggle">
        <dt class="title">Not Applicable: </dt>
        <dd class="count"><xsl:value-of select="$numBenchNotApp"/></dd>
        </dl>
        <ol class="hidden">
                <xsl:if test="$numBenchNotApp &gt; 0">
                    <xsl:apply-templates select="//*[local-name(.)='rule-result']/*[local-name(.)='result'][.='notapplicable']/..">
                        <xsl:with-param name="result" select="'NOT APPLICABLE'"/>
                    </xsl:apply-templates>
                </xsl:if>
        </ol>
    </li>
    <li>
        <dl class="result toggle">
        <dt class="title">Not Selected: </dt>
        <dd class="count"><xsl:value-of select="$numBenchNotSelected"/></dd>
        </dl>
        <ol class="hidden">
                <xsl:if test="$numBenchNotSelected &gt; 0">
                    <xsl:apply-templates select="//*[local-name(.)='rule-result']/*[local-name(.)='result'][.='notselected']/..">
                        <xsl:with-param name="result" select="'NOT SELECTED'"/>
                    </xsl:apply-templates>
                </xsl:if>
        </ol>
    </li>
    <li>
        <dl class="result toggle">
        <dt class="title">Fixed: </dt>
        <dd class="count"><xsl:value-of select="$numBenchFixed"/></dd>
        </dl>
        <ol class="hidden">
                <xsl:if test="$numBenchFixed &gt; 0">
                    <xsl:apply-templates select="//*[local-name(.)='rule-result']/*[local-name(.)='result'][.='fixed']/..">
                        <xsl:with-param name="result" select="'FIXED'"/>
                    </xsl:apply-templates>
                </xsl:if>
        </ol>
    </li>
    <li>
        <dl class="result toggle">
        <dt class="title">Parse Error: </dt>
        <dd class="count"><xsl:value-of select="$numBenchParseError"/></dd>
        </dl>
        <ol class="hidden">
                <xsl:if test="$numBenchParseError &gt; 0">
                    <xsl:apply-templates select="//x:rule-result[not(x:result)]">
                        <xsl:with-param name="result" select="'PARSE ERROR'"/>
                    </xsl:apply-templates>
                </xsl:if>
        </ol>
    </li>
    </ol>
    <li>
        <dl class="result toggle">
        <dt class="title">Total: </dt>
        <dd class="count"><xsl:value-of select="$numBenchTotal"/></dd>
        </dl>
        <ol class="hidden">
                <xsl:if test="$numBenchTotal &gt; 0">
                    <xsl:apply-templates select="//x:rule-result">
                        <xsl:with-param name="result" select="'RESULT'"/>
                    </xsl:apply-templates>
                </xsl:if>
        </ol>
    </li>
    </li>
</xsl:template>

<xsl:template match="*[local-name(.)='oval_results']">
    <xsl:param name="count" select="0"/>
    <xsl:variable name="resultDefs" select="//*[local-name(.)='results']//*[local-name(.)='definition']"/>
    <xsl:variable name="ovalDefs" select="//*[local-name(.)='oval_definitions']//*[local-name(.)='definition']"/>
    <li>
        <dl class="result toggle">
        <dt class="title">Failures: </dt>
        <dd class="count"><xsl:value-of select="$numOvalFalse"/></dd>
        </dl>
        <ol class="hidden">
                <xsl:if test="$numOvalFalse &gt; 0">
                    <xsl:for-each select="$resultDefs[@result='false']">
                        <xsl:variable name="defID" select="@definition_id"/>
                        <li>
                        <span class="toggle">
                            <span class="counter title">FAILURE <xsl:value-of select="position()"/></span>: <xsl:value-of select="$ovalDefs[@id=$defID]/*[local-name(.)='metadata']/*[local-name(.)='description']"/>
                        </span>
                        <ol class="hidden">
                        <li>
                            <xsl:apply-templates select="$ovalDefs[@id=$defID]"/>
                        </li>
                        </ol>
                        </li>
                    </xsl:for-each>
                </xsl:if>
        </ol>
    </li>
    <li>
        <dl class="result toggle">
        <dt class="title">Passes: </dt>
        <dd class="count"><xsl:value-of select="$numOvalTrue"/></dd>
        </dl>
        <ol class="hidden">
                <xsl:if test="$numOvalTrue &gt; 0">
                    <xsl:for-each select="$resultDefs[@result='true']">
                        <xsl:variable name="defID" select="@definition_id"/>
                        <li>
                        <span class="toggle">
                            <span class="counter title">PASS <xsl:value-of select="position()"/></span>: <xsl:value-of select="$ovalDefs[@id=$defID]/*[local-name(.)='metadata']/*[local-name(.)='description']"/>
                        </span>
                        <ol class="hidden">
                        <li>
                            <xsl:apply-templates select="$ovalDefs[@id=$defID]"/>
                        </li>
                        </ol>
                        </li>
                    </xsl:for-each>
                </xsl:if>
        </ol>
    </li>
    <li>
        <dl class="result toggle">
        <dt class="title">Unknown: </dt>
        <dd class="count"><xsl:value-of select="$numOvalUnknown"/></dd>
        </dl>
        <ol class="hidden">
                <xsl:if test="$numOvalUnknown &gt; 0">
                    <xsl:for-each select="$resultDefs[@result='unknown']">
                        <xsl:variable name="defID" select="@definition_id"/>
                        <li>
                        <span class="toggle">
                            <span class="counter title">UNKNOWN <xsl:value-of select="position()"/></span>: <xsl:value-of select="$ovalDefs[@id=$defID]/*[local-name(.)='metadata']/*[local-name(.)='description']"/>
                        </span>
                        <ol class="hidden">
                        <li>
                            <xsl:apply-templates select="$ovalDefs[@id=$defID]"/>
                        </li>
                        </ol>
                        </li>
                    </xsl:for-each>
                </xsl:if>
        </ol>
    </li>
    <li>
        <dl class="result toggle">
        <dt class="title">Not Evaluated: </dt>
        <dd class="count"><xsl:value-of select="$numOvalNotEval"/></dd>
        </dl>
        <ol class="hidden">
                <xsl:if test="$numOvalNotEval &gt; 0">
                    <xsl:for-each select="$resultDefs[@result='not evaluated']">
                        <xsl:variable name="defID" select="@definition_id"/>
                        <li>
                        <span class="toggle">
                            <span class="counter title">NOT EVALUATED <xsl:value-of select="position()"/></span>: <xsl:value-of select="$ovalDefs[@id=$defID]/*[local-name(.)='metadata']/*[local-name(.)='description']"/>
                        </span>
                        <ol class="hidden">
                        <li>
                            <xsl:apply-templates select="$ovalDefs[@id=$defID]"/>
                        </li>
                        </ol>
                        </li>
                    </xsl:for-each>
                </xsl:if>
        </ol>
    </li>
    <li>
        <dl class="result toggle">
        <dt class="title">Not Applicable: </dt>
        <dd class="count"><xsl:value-of select="$numOvalNotApp"/></dd>
        </dl>
        <ol class="hidden">
                <xsl:if test="$numOvalNotApp &gt; 0">
                    <xsl:for-each select="$resultDefs[@result='not applicable']">
                        <xsl:variable name="defID" select="@definition_id"/>
                        <li>
                        <span class="toggle">
                           <span class="counter title">NOT APPLICABLE <xsl:value-of select="position()"/></span>: <xsl:value-of select="$ovalDefs[@id=$defID]/*[local-name(.)='metadata']/*[local-name(.)='description']"/>
                        </span>
                        <ol class="hidden">
                        <li>
                            <xsl:apply-templates select="$ovalDefs[@id=$defID]"/>
                        </li>
                        </ol>
                        </li>
                    </xsl:for-each>
                </xsl:if>
        </ol>
    </li>
</xsl:template>

<xsl:template match="*[local-name(.)='results']">
         <dl id="oval">
            <dt class="title white">Audit Summary</dt>
            <dd>
                <dl class="summary">
                    <dt>OVAL Filename: </dt>
                    <dd><xsl:if test="not($ovalid)">Unknown</xsl:if><xsl:value-of select="$ovalid"/></dd>
                    <dt>Failures: </dt>
                    <dd><xsl:value-of select="$numOvalFalse"/></dd>
                    <dt>Passes: </dt>
                    <dd><xsl:value-of select="$numOvalTrue"/></dd>
                    <dt>Unknown: </dt>
                    <dd><xsl:value-of select="$numOvalUnknown"/></dd>
                    <dt>Error: </dt>
                    <dd><xsl:value-of select="$numOvalError"/></dd>
                    <dt>Not Evaluated: </dt>
                    <dd><xsl:value-of select="$numOvalNotEval"/></dd>
                    <dt>Not Applicable: </dt>
                    <dd><xsl:value-of select="$numOvalNotApp"/></dd>
                </dl>
            </dd>
        </dl>
</xsl:template>

<xsl:template match="*[local-name(.)='rule-result']">
    <xsl:param name="result"/>
    <xsl:variable name="status" select="*[local-name(.)='result']"/>
    <xsl:variable name="override" select="*[local-name(.)='override']"/>
    <xsl:variable name="idref" select="@idref"/>
    <xsl:variable name="rule" select="//*[local-name(.)='Rule'][@id=$idref]"/>
         <li>
            <span class="toggle"><span class="counter title"><xsl:value-of select="$result"/>&#160;<xsl:value-of select="position()"/></span>: <xsl:value-of select="$idref"/> - </span>
            <span><xsl:value-of select="$rule/*[local-name(.)='description']"/></span>
            <ol class="hidden">
                <xsl:if test="$status = 'fail'">
                    <li>FixText : <xsl:value-of select="$rule/*[local-name(.)='fixtext']"/></li>
                </xsl:if>
                <xsl:if test="$status = 'informational'">
                    <xsl:variable name="authBy" select="$override/*[local-name(.)='authority']"/>
                    <table class="details">
                        <tr>
                        <td>Actual Result: </td>
                        <td class="title"><xsl:value-of select="$override/*[local-name(.)='old-result']"/></td>
                        </tr>
                        <tr>
                        <td>Authority: </td>
                        <xsl:choose>
                            <xsl:when test="not($authBy)">
                                <td class="title">N/A</td>
                            </xsl:when>
                            <xsl:otherwise>
                                <td class="title"><xsl:value-of select="$authBy"/></td>
                            </xsl:otherwise>
                        </xsl:choose>
                        </tr>
                        <tr>
                        <td>Remark: </td>
                        <td class="title"><xsl:value-of select="$override/*[local-name(.)='remark']"/></td>
                        </tr>
                    </table>
                </xsl:if>
                <xsl:apply-templates select="$rule//*[local-name(.)='check-content-ref']"/>
            </ol>
        </li>
</xsl:template>

<xsl:template match="*[local-name(.)='check-content-ref']">
        <li>
            <xsl:variable name="oval" select="@href"/>
            <xsl:variable name="defid" select="@name"/>
            <xsl:variable name="ovalres" select="concat(substring-before($oval, '.xml'), '.results.xml')"/>
            <xsl:variable name="ovalresdoc" select="document(concat($path,$ovalres))"/>
            <!--<xsl:variable name="result" 
                          select="$ovalresdoc//*[local-name(.)='results']//*[local-name(.)='definition'][@definition_id=$defid]/@result"/>-->
            <xsl:variable name="OvalDef" select="$ovalresdoc//*[local-name(.)='definition']"/>
            <xsl:apply-templates select="$OvalDef[@id=$defid]"/>
        </li>
</xsl:template>

<xsl:template match="*[local-name(.)='definition']">
    <xsl:variable name="defID" select="@id"/>
    <xsl:variable name="defResult" select="//*[local-name(.)='results']//*[local-name(.)='definition'][@definition_id=$defID]/@result"/>
    <span class="title">
        <xsl:value-of select="*[local-name(.)='metadata']/*[local-name(.)='title']"/>
        <span class="ovalid"> ( <xsl:value-of select="@id"/> )</span>
    </span>
    <ol class="test">
        <xsl:apply-templates select="*[local-name(.)='criteria']/*[local-name(.)='criterion']">
            <xsl:with-param name="defResult" select="$defResult"/>
        </xsl:apply-templates>
    </ol>
</xsl:template>

<xsl:template match="*[local-name(.)='criterion']">
    <xsl:param name="defResult"/>
    <xsl:variable name="test_id" select="@test_ref"/>
    <xsl:variable name="test" select="//*[local-name(.)='results']//*[local-name(.)='test'][@test_id=$test_id]"/>
    <xsl:if test="$test">
        <xsl:variable name="defResult" select="@result"/>
    </xsl:if>
    <li>
        <xsl:value-of select="//*[local-name(.)][@id=$test_id]/@comment"/> 
        [ <span class="title"> <xsl:value-of select="$defResult"/> </span> ]
        <span class="ovalid"> ( <xsl:value-of select="$test_id"/> )</span>
    </li>
    <ol>
    <li>check: 
        <span class="title"> 
            <xsl:if test="not($test/@check)">
                all
            </xsl:if>
            <xsl:value-of select="$test/@check"/> 
        </span>
    </li>
    <li>check_existence: 
        <span class="title"> 
            <xsl:if test="not($test/@check_existence)">
                all_exist
            </xsl:if>
            <xsl:value-of select="$test/@check_existence"/> 
        </span>
    </li>
    <li>
        <div>State</div>
        <xsl:for-each select="//*[local-name(.)='tests']/*[local-name(.)]">
            <xsl:if test="@id = $test_id">
                <xsl:variable name="state_id" select="*[local-name(.)='state']/@state_ref"/>
                <xsl:choose>
                    <xsl:when test="not($state_id)">
                        <dl><dt>None</dt></dl>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="//*[local-name(.)='states']/*[local-name(.)][@id=$state_id]"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
        </xsl:for-each>
    </li>
    <li>
        <dl class="details">
        <xsl:choose>
            <xsl:when test="not($test)">
                    <dt class="title">Nothing Tested</dt>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="$test"/>
            </xsl:otherwise>
        </xsl:choose>
        </dl>
    </li>
    </ol>
</xsl:template>

<xsl:template match="*[local-name(.)='test']">
    <xsl:if test="*[local-name(.)='tested_item']">
        <dt>Tested Items</dt>
        <xsl:apply-templates select="*[local-name(.)='tested_item']"/>
    </xsl:if>
    <xsl:if test="*[local-name(.)='tested_variable']">
        <xsl:variable name="var_id" select="*[local-name(.)='tested_variable']/@variable_id"/>
        <dt>Tested Variables</dt>
        <dd>
        <dl>
            <dt class="toggle"><xsl:value-of select="//*[local-name(.)='variables']//*[@id=$var_id]/@comment"/></dt>
            <dd class="hidden">
                <ol>
                    <xsl:apply-templates select="*[local-name(.)='tested_variable']"/>
                </ol>
            </dd>
        </dl>
        </dd>
    </xsl:if>
</xsl:template>

<xsl:template match="*[local-name(.)='tested_item']">
        <xsl:variable name="item_id" select="@item_id"/>
        <xsl:variable name="result" select="@result"/>
        <dd><dl class="tested">
        <!--<xsl:apply-templates select="//*[local-name(.)='system_data']//*[@id=$item_id]"/>-->
            <xsl:for-each select="//*[local-name(.)='system_data']//*[@id=$item_id]">
                <dt class="toggle"><xsl:value-of select="local-name(.)"/> [ <span class="title"> <xsl:value-of select="$result"/> </span> ] </dt>
                <dd class="hidden">
                <table>
                <xsl:for-each select="*">
                    <tr>
                    <td style="font-weight: normal"><xsl:value-of select="local-name(.)"/>: </td>
                    <td><xsl:value-of select="."/></td>
                    </tr>
                </xsl:for-each>
                </table>
                </dd>
            </xsl:for-each>
       </dl></dd>
</xsl:template>

<xsl:template match="*[local-name(.)='tested_variable']">
        <li><xsl:value-of select="."/></li>            
</xsl:template>

<xsl:template match="*[local-name(.)='states']/*">
<dl class="details">
    <xsl:for-each select="*">
        <dt class="toggle"><xsl:value-of select="local-name(.)"/></dt>
        <dd class="hidden">
        <xsl:if test="@var_ref != ''">
            <xsl:variable name="var" select="@var_ref"/>
            <dl>
            <xsl:apply-templates select="//*[local-name(.)='variables']/*[local-name(.)][@id=$var]">
                <xsl:with-param name="var" select="$var"/>
            </xsl:apply-templates>
            </dl>
        </xsl:if>
        <xsl:value-of select="."/>
        </dd>
    </xsl:for-each>
</dl>
</xsl:template>

<xsl:template match="*[local-name(.)='external_variable']">
    <xsl:param name="var"/>
    <xsl:variable name="value_id" select="$original//*[local-name(.)='check-export'][@export-name=$var]/@value-id"/>
        <dt class="toggle"><xsl:value-of select="local-name(.)"/></dt>
        <dd class="hidden"><xsl:apply-templates select="$original//*[local-name(.)='Value'][@id=$value_id]"/></dd>
</xsl:template>

<xsl:template match="*[local-name(.)='constant_variable']">
    <dt class="toggle"><xsl:value-of select="local-name(.)"/></dt>
    <dd>
    <table>
    <tr>
    <xsl:for-each select="*">
        <td><xsl:value-of select="local-name(.)"/></td>
        <td><xsl:value-of select="."/></td>
    </xsl:for-each>
    </tr>
    </table>
    </dd>
</xsl:template>

<xsl:template match="*[local-name(.)='local_variable']">
    <dt class="toggle"><xsl:value-of select="local-name(.)"/></dt>
    <dd class="hidden">
    <dl>
            <xsl:for-each select="*">
                <dt class="toggle"><xsl:value-of select="local-name(.)"/></dt>
                <dd class="hidden"><xsl:apply-templates select="."/></dd>
            </xsl:for-each>
    </dl>
    </dd>
</xsl:template>

<xsl:template match="*[local-name(.)='object_component']">
    <xsl:variable name="obj_ref" select="@object_ref"/>
    <dl>
        <dt>
        <table>
        <tr>
            <td>item_field:</td>
            <td><xsl:value-of select="@item_field"/></td>
        </tr>
        </table>
        </dt>
        <dd>
            <dl>
            <xsl:apply-templates select="//*[local-name(.)='collected_objects']/*[local-name(.)='object'][@id=$obj_ref]/*[local-name(.)='reference']"/>
            </dl>
        </dd>
    </dl>
</xsl:template>

<xsl:template match="*[local-name(.)='variable_component']">
    <xsl:variable name="var" select="@var_ref"/>
    <dl>
        <xsl:apply-templates select="//*[local-name(.)='variables']/*[local-name(.)][@id=$var]">
            <xsl:with-param name="var" select="$var"/>
        </xsl:apply-templates>
    </dl>
</xsl:template>

<xsl:template match="*[local-name(.)='literal_component']">
    <dt class="toggle"><xsl:value-of select="local-name(.)"/></dt>
    <dd>
    <table>
    <tr>
        <td><xsl:value-of select="local-name(.)"/></td>
        <td><xsl:value-of select="."/></td>
    </tr>
    </table>
    </dd>   
</xsl:template>

<xsl:template match="*[local-name(.)='reference']">
    <xsl:variable name="item_id" select="@item_ref"/>
            <xsl:for-each select="//*[local-name(.)='system_data']//*[@id=$item_id]">
                <dt><xsl:value-of select="local-name(.)"/></dt>
                <dd>
                <table>
                <xsl:for-each select="*">
                    <tr>
                    <td style="font-weight: normal"><xsl:value-of select="local-name(.)"/>: </td>
                    <td><xsl:value-of select="."/></td>
                    </tr>
                </xsl:for-each>
                </table>
                </dd>
            </xsl:for-each>
</xsl:template>

<xsl:template match="*[local-name(.)='Value']">
<table>
    <xsl:variable name="value_id" select="@value-id"/>
    <tr>
        <td style="font-weight: normal"><xsl:value-of select="@id"/>:</td>
        <td><xsl:value-of select="*[local-name(.)='title']"/></td>
    </tr>
    <tr>
        <td style="font-weight: normal">value: </td>
        <td><xsl:value-of select="*[local-name(.)='value']"/></td>
    </tr>
</table>
</xsl:template>

<xsl:template match="*[local-name(.)='system_info']">
    <dl id="sysinfo">
        <dt class="title white">System Information</dt>
        <dd>
            <dl class="summary">
                <dt>Host Name: </dt>
                <dd><xsl:value-of select="*[local-name(.)='primary_host_name']"/></dd>
                <dt>Operating System (OS): </dt>
                <dd><xsl:value-of select="*[local-name(.)='os_name']"/></dd>
                <dt>OS Version: </dt>
                <dd><xsl:value-of select="*[local-name(.)='os_version']"/></dd>
                <dt>Architecture: </dt>
                <dd><xsl:value-of select="*[local-name(.)='architecture']"/></dd>
            </dl>
        </dd>
    </dl>
</xsl:template>

</xsl:stylesheet>
