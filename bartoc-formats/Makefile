BARTOC=https://bartoc.org/en/node/20000
include ../Makefile

$(CONCEPTS): bartoc-formats-concepts.csv $(SCHEME)
	$(jskos-convert) concepts -l en -s bartoc-formats-scheme.ndjson -m $< > $@
