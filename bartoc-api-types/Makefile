include ../Makefile

$(CONCEPTS): bartoc-api-types-concepts.csv $(SCHEME)
	$(jskos-convert) concepts -l en -s bartoc-api-types-scheme.ndjson -m $< > $@