#!/usr/bin/bash

API=https://coli-conc.gbv.de/coli-ana/app/analyze

all=ddc100-ana.ndjson

awk -F, '{print $2}' ddc-concepts.csv | grep '^...$'  | while read notation; do
    echo "$notation" >&2
    curl -s "$API?notation=$notation" | jq -c .[]
done > $all

<$all jq '{key:.uri,value:[.memberList[]|select(.ATOMIC)|{uri}]}|select(.value|length>1)' | jq -s from_entries > ddc-atoms.json
