include ../Makefile

$(CONCEPTS): bartoc-kos-types-concepts.csv $(SCHEME)
	$(jskos-convert) concepts -l en -s bartoc-kos-types-scheme.ndjson -m $< > $@