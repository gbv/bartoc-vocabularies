include ../Makefile

$(SCHEME):
	curl --silent 'https://bartoc.org/api/data?uri=http%3A%2F%2Fbartoc.org%2Fen%2Fnode%2F21150' | jq .[] -Sc > $@
	
$(CONCEPTS): bartoc-kos-types-concepts.csv $(SCHEME)
	$(jskos-convert) concepts -l en -s bartoc-kos-types-scheme.ndjson -m $< > $@
