include ../Makefile

$(CONCEPTS):
	curl -L --silent https://api.dante.gbv.de/voc/license/top | jq -c '.[]' > $@
