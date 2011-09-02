<!--
    idl-extract.xslt: 
    XSLT transformation to extract IDL Definitions from RFC2629 XML documents
    This is binded to the convention adopted by CICM documents and shouldn't
    be relevant in other standardization contexts.

    Copyright (c) 2011, Alfonso De Gregorio, secYOUre by SecurityPillar Ltd
    (adg@secYOUre.com adg@crypto.lo.gy) All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice,
      this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice,
      this list of conditions and the following disclaimer in the documentation
      and/or other materials provided with the distribution.
    * Neither the name of Julian Reschke nor the names of its contributors
      may be used to endorse or promote products derived from this software
      without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
    ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
    LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
    CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
    SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
    INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
    CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
    POSSIBILITY OF SUCH DAMAGE.
-->

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"

                xmlns:date="http://exslt.org/dates-and-times"
                xmlns:ed="http://greenbytes.de/2002/rfcedit"
                xmlns:exslt="http://exslt.org/common"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:myns="mailto:adg@crypto.lo.gy?subject=idl-extract.xslt"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:saxon-old="http://icl.com/saxon"
                xmlns:x="http://purl.org/net/xml2rfc/ext"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"

                exclude-result-prefixes="date ed exslt msxsl myns rdf saxon saxon-old x xhtml" >

<xsl:output method="text" encoding="iso-8859-1" omit-xml-declaration="yes" mime-type="text/plain" indent="no"/>

<!--
<xsl:param name="xml2rfc-idlcode">
  <xsl:call-template name="parse-pis">
    <xsl:with-param name="nodes" select="/processing-instruction('rfc')"/>
    <xsl:with-param name="attr" select="'idlcode'"/>
    <xsl:with-param name="default" select="'yes'"/>
  </xsl:call-template>
</xsl:param>
-->


<xsl:template match="text()" />
<xsl:template match="//*[@anchor='idl-code']">
    <xsl:call-template name="idlcode"/>
</xsl:template>

<xsl:template match="node()|@*" mode="identity" name="idlcode">
    <xsl:copy>
        <xsl:apply-templates select="node()|@*" mode="identity"/>
    </xsl:copy>
</xsl:template>

</xsl:transform>
