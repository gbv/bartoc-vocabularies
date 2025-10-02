# get name of current directory
NAME := $(shell basename `pwd`)
SCHEME := $(NAME)-scheme.ndjson
CONCEPTS := $(NAME)-concepts.ndjson

# run scripts as installed via npm to ensure stable version
jskos-convert=npm run --silent jskos-convert --

# make scheme and concepts by default
default: $(SCHEME) $(CONCEPTS)
