# bartoc-vocabularies

This repository contains auxiliary vocabularies used in [BARTOC](https://bartoc.org/) encoded in [JSKOS data format](https://gbv.github.io/jskos/).

## Usage

Each vocabulary data is located in a subdirectory `$ID` (lowercase short name or acronym) with either one or more of the following JSKOS data files:

* `$ID-scheme.json`
* `$ID-concepts.ndjson`

The files should be generated automatically via a `Makefile`. Its sources such as CSV files should be included as well. Each directory should further contain a brief `README.md` giving a title and links to sources and additional resources such as instructions how to update the data.

To re-generate jskos for a given vocabulary, run:

    make -sBC $ID

The skript `import.sh` takes an API-URI `$APIURI`, like `https://bartoc.org/api/` or `http://localhost:3000/` for testing, as input and adds it in an API field, with the type jskos-API, to the scheme of all vocabularies. It furthermore imports the schemes and concepts to the jskos-server, like one in https://github.com/gbv/jskos-server, of the corresponding API-URI via POST requests. Existing schemes and concepts will be overwritten. The skript will skip vocabularies with missing schemes or concepts and give a warning.

    sh import.sh $APIURI

## Requirements

Scripts are only testet on Linux. Specific requirements to generate JSKOS files depend on the source format. In any case, the following should be installed:

* make
* [jq](https://stedolan.github.io/jq/)
* node and some npm modules (run `npm install`)
