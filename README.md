# iiif-schemas

Standardized XML data models for IIIF primary resource types will simplify the expression of XML-based resources (METS/ALTO objects, TEI objects, etc.) by providing an intermediate data format that can be converted to the JSON-LD required by IIIF-compliant services.

This project will provide a relax-ng schema for IIIF resource types which may be used to validate an XML document prior to, for example, conversion to JSON.

If there is time and interest, it would be great to include support code as well: converters from XML->JSON (and possibly from JSON->XML, though I don't see the use case); Schematron rules; etc.
