include ../Makefile

$(CONCEPTS): bartoc-access-concepts.csv $(SCHEME)
	$(jskos-convert) concepts -l en -s bartoc-access-scheme.ndjson -m $< > $@