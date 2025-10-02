#!/bin/bash

error() {
    echo "📕 $@"
}    

vocimport() {
    APIURI="$1"
    dir="$2"

    if [ ! -d "$dir" ]; then
        error "Not a directory: $dir"
        echo 
        return
    fi

    echo "$dir"

    id=${dir%/}
    SCHEME="$dir$id-scheme.ndjson"
    CONCEPTS="$dir$id-concepts.ndjson"

    if [ ! -f "$SCHEME" ]; then
        error "Missing scheme: $dir"
        echo 
        return
    fi

    if [ ! -f "$CONCEPTS" ]; then
        error "Missing concepts: $dir"
        echo 
        return
    fi

    echo -n "scheme:"

    jq --arg APIURI "$APIURI" '.API += [{"url":$APIURI, "type":"http://bartoc.org/api-type/jskos"}]' "$SCHEME" \
    | curl -s -X POST --json @- "${APIURI}voc?bulk=1" | wc -l

    echo -n "concepts:"

    curl -s -X POST -H 'Content-Type: application/x-ndjson' --data-binary "@${CONCEPTS}" "${APIURI}concepts?bulk=1&type=ndjson" | wc -l

    echo 

}

for dir in */; do
    [ "$dir" = "node_modules/" ] && continue
    vocimport "$1" "$dir"
done