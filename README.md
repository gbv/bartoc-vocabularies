# BARTOC Vocabularies

This repository contains auxiliary vocabularies used in [BARTOC](https://bartoc.org/) encoded in [JSKOS data format](https://gbv.github.io/jskos/), and scripts to update and import these vocabularies:

- [BARTOC access modes](bartoc-access)
- [BARTOC vocabulary API types](bartoc-api-types)
- [BARTOC data formats](bartoc-formats)
- [Dewey Decimal Classification](ddc), limited to the first three levels
- [ISO Language Codes (639-1 and 693-2) and IETF Language Types](languages)
- [KOS Types Vocabulary](nkostype)

## Requirements

Update and import scripts require command line tools `bash`, `make`, `curl`, [jq](https://stedolan.github.io/jq/), and node. Then install required node modules with `npm install`.

## Usage

Each vocabulary data is located in a subdirectory `$ID` (lowercase short name or acronym) with two JSKOS data files:

* `$ID-scheme.json` with information about the vocabulary
* `$ID-concepts.ndjson` with concepts of the vocabulary

The concepts file can be updated with a `Makefile` from a CSV file or from an external source, depending in the vocabulary. Each directory further contains a brief `README.md` giving a title and links to sources and additional resources such as instructions how to update the data. To force re-generation of a concepts file, run:

    make -BC $ID

The skript `import.sh` takes a JSKOS-API endpoint URL such as `http://localhost:3000/` or `https://bartoc.org/api/` as first argument. It adds this URL to the `API` field of the vocabulary and imports the vocabulary and its concepts. Existing schemes and concepts will be overwritten!
