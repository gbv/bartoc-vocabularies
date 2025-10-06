include ../Makefile

$(CONCEPTS): ddc-concepts.csv $(SCHEME)
	$(jskos-convert) concepts -l en -s ddc-scheme.ndjson -m $< > $@