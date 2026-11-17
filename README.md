[![Build and publish Docker image](https://github.com/gbv/bartoc-vocabularies/actions/workflows/docker.yml/badge.svg)](https://github.com/gbv/bartoc-vocabularies/actions/workflows/docker.yml)

# BARTOC Vocabularies

This repository contains auxiliary vocabularies used in [BARTOC](https://bartoc.org/) encoded in [JSKOS data format](https://gbv.github.io/jskos/), and scripts to update and import these vocabularies:

- [BARTOC access modes](bartoc-access)
- [BARTOC vocabulary API types](bartoc-api-types)
- [BARTOC data formats](bartoc-formats)
- [Dewey Decimal Classification](ddc) reduced to the first three digits, including table numbers and English labels
- [ISO Language Codes (639-1 and 693-2) and IETF Language Types](languages)
- [KOS Types Vocabulary](nkostype)

## Requirements

Update and import scripts require command line tools `bash`, `make`, `curl`, [jq](https://stedolan.github.io/jq/), and node. Then install required node modules with `npm install`.

## Usage

Each vocabulary data is located in a subdirectory `$ID` (lowercase short name or acronym) with two JSKOS data files:

* `$ID-scheme.ndjson` with information about the vocabulary
* `$ID-concepts.ndjson` with concepts of the vocabulary

The concepts file can be updated with a `Makefile` from a CSV file or from an external source, depending in the vocabulary. Each directory further contains a brief `README.md` giving a title and links to sources and additional resources such as instructions how to update the data. To force re-generation of a concepts file, run:

    make -BC $ID

The script `import.sh` takes a JSKOS-API endpoint URL such as `http://localhost:3000/` or `https://bartoc.org/api/` as first argument. It adds this URL to the `API` field of the vocabulary and imports the vocabulary and its concepts.

Environment variable `JWT` can optionally be set to provide a JWT Token for authentification for import.

Existing schemes and concepts will be overwritten but no concepts will be deleted.

## Development and production workflow

Validate vocabulary changes locally before pushing:

    npm run validate

Vocabulary changes are first pushed to the `dev` branch. After successful validation, GitHub Actions publishes `ghcr.io/gbv/bartoc-vocabularies:dev`. Deployment automation configured in [coli-conc-server](https://github.com/gbv/coli-conc-server) then imports the changed vocabularies into [dev.bartoc.org](https://dev.bartoc.org/).

Review and test the changes on dev.bartoc.org. Once they are ready for production, publish the local `dev` branch to `main` with:

    npm run release

This command runs the validation again and atomically pushes the local `dev` branch to both `dev` and `main` on GitHub. The push fails if `main` cannot be fast-forwarded to `dev`.

After the push, GitHub Actions publishes `ghcr.io/gbv/bartoc-vocabularies:main`, and the server-side automation imports the changed vocabularies into [bartoc.org](https://bartoc.org/).
