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
	<word name="world">текст</word>
	...
	<word name="act">glumiti</word>
</dictionary>
```