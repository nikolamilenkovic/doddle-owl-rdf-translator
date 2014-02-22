## Description
This XSLT transformation file was created for the purpose of translating DODDLE-OWL files. DODDLE-OWL works only with English and Japanese languages, and this transformation file allows you to work with any other natural language.

## Dictionary
owl-transform.xsl depends on dictionary.xml which contains mappings from English to target language. File structure is straightforward (example shows mapping from English to Serbian):

```xml
<?xml version="1.0" encoding="UTF-8"?>
<dictionary>
	<word name="kitchen">кухиња</word>
	<word name="doors">врата</word>
	<word name="river">река</word>
	<word name="sun">сунце</word>
	<word name="reality">реалност</word>
	<word name="world">свет</word>
	...
	<word name="act">glumiti</word>
</dictionary>
```

## Usage
In order to perform the translation of the DODDLE-OWL file, an XSLT processor is required. In the example below, [msxsl](http://www.microsoft.com/en-us/download/details.aspx?id=21714) is used.

    msxsl.exe example\example.owl owl-transform.xsl -o example\out.owl

This will translate the file with contents like this
```xml
	...
	<owl:disjointWith>
		<owl:Class rdf:ID="course"/>
	</owl:disjointWith>
	<rdfs:label xml:lang="en">program</rdfs:label>
</owl:Class>
<owl:Class rdf:about="#course">
	<rdfs:subClassOf>
		<owl:Class rdf:about="#act"/>
	</rdfs:subClassOf>
	<rdfs:label xml:lang="en">course</rdfs:label>
	...
```
to equivalent file with translated contents
```xml
	<owl:disjointWith>
		<owl:Class rdf:ID="курс"></owl:Class>
	</owl:disjointWith>
	<rdfs:label xml:lang="sr">програм</rdfs:label>
</owl:Class>
<owl:Class rdf:about="#курс">
	<rdfs:subClassOf>
		<owl:Class rdf:about="#glumiti"></owl:Class>
    </rdfs:subClassOf>
	<rdfs:label xml:lang="sr">курс</rdfs:label>
	...
```