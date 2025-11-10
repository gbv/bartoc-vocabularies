include ../Makefile

$(CONCEPTS): ddc-concepts.csv $(SCHEME) ddc-atoms.json
	$(jskos-convert) concepts -l en -s ddc-scheme.ndjson -m $< > $@
	node ./merge.js
