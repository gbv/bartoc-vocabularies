BARTOC=https://bartoc.org/en/node/1665
include ../Makefile

$(CONCEPTS):
	curl -L --silent http://api.dante.gbv.de/voc/nkostype/top \
  | jq -c '.[]|.inScheme[0].uri = "$(BARTOC)"' > $@
