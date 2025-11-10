# Dewey Decimal Classification (DDC)

This directory contains a subset of DDC (<https://bartoc.org/en/node/241>), limited to the first three levels:

- `ddc-scheme.ndjson`: metadata about DDC
- `ddc-concepts.csv`: simple hierarchy and English labels, including table numbers found by decomposition of DDC notations up to three digits
- `ddc-concepts.ndjson`: same converted to JSKOS and enriched with field `memberSet` for decomposition (run `make` from this directory to update)
- `coli-ana.sh`: script to retrieve decompositions via coli-ana API and generate:
    - `ddc100-ana.ndjson`: cached response from coli-ana API
    - `ddc-atoms.json`: retrieved decomposition, reduced to atomic concepts for DDC notations build with table numbers
- `merge.js`: script to merge `ddc-atoms.json` into `ddc-concepts.ndsjon'

