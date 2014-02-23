<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
	xmlns:owl="http://www.w3.org/2002/07/owl#">
	<xsl:output method="xml" indent="yes"/>

	<xsl:variable name="dict" select="document('dictionary.xml')/*" />
	<xsl:variable name="sourceLanguage" select="$dict/@from" />
	<xsl:variable name="targetLanguage" select="$dict/@to" />
	
    <xsl:template match="@* | node()">
        <xsl:copy>
			<xsl:choose>
				<xsl:when test=".=rdfs:label"><xsl:apply-templates select="rdfs:label"/></xsl:when>
				<xsl:when test=".=owl:disjointWith"><xsl:apply-templates select="owl:disjointWith"/></xsl:when>
				<xsl:otherwise><xsl:apply-templates select="@* | node()"/></xsl:otherwise>
			</xsl:choose>            
        </xsl:copy>
    </xsl:template>
	
	<xsl:template match="rdfs:label">
		<xsl:variable name="word" select="." />
		<rdfs:label xml:lang="{$sourceLanguage}"><xsl:value-of select="$word"/></rdfs:label>
		<rdfs:label xml:lang="{$targetLanguage}"><xsl:value-of select="$dict/word[@name=$word]"/></rdfs:label>
	</xsl:template>
	
	<xsl:template match="owl:Class">
		<xsl:if test="@rdf:ID">
			<xsl:variable name="word" select="@rdf:ID" />
			<xsl:variable name="translated_word">
				<xsl:value-of select="$dict/word[@name=$word]"/>
			</xsl:variable>
			
			<owl:Class rdf:ID="{$translated_word}"><xsl:apply-templates /></owl:Class>
		</xsl:if>
		
		<xsl:if test="@rdf:about">
			<xsl:variable name="word" select="substring(@rdf:about, 2)" />
			<xsl:variable name="translated_word">
				<xsl:value-of select="$dict/word[@name=$word]"/>
			</xsl:variable>
			
			<owl:Class rdf:about="{concat('#',$translated_word)}"><xsl:apply-templates /></owl:Class>
		</xsl:if>
		
		
	</xsl:template>
	
	<xsl:template match="owl:disjointWith">
		<xsl:choose>
			<xsl:when test="@rdf:resource">
				<xsl:variable name="word" select="substring(@rdf:resource, 2)" />
				<xsl:variable name="translated_word">
					<xsl:value-of select="$dict/word[@name=$word]"/>
				</xsl:variable>
				<owl:disjointWith rdf:resource="{concat('#',$translated_word)}" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@* | node()"/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	
	</xsl:template>
</xsl:stylesheet>