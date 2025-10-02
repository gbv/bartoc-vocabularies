BARTOC=https://bartoc.org/en/node/241
include ../Makefile

$(CONCEPTS): ddc-concepts.csv $(SCHEME)
	$(jskos-convert) concepts -l en -s ddc-scheme.ndjson -m $< > $@