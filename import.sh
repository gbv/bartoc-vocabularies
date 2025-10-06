#!/bin/bash
set -euo pipefail

API=$1

curl_headers=(-s --fail-with-body)
if [ -n "${JWT:-}" ]; then
  curl_headers+=("-H" "Authorization: Bearer $JWT")
fi

error() {
    echo "📕 $@"
    exit 1
}    

import() {
    dir=${1%/}

    scheme="$dir/$dir-scheme.ndjson"
    concepts="$dir/$dir-concepts.ndjson"

    [ -f "$scheme" ] || error "Missing $scheme"
    [ -f "$concepts" ] || error "Missing $concepts"

    # add or overwrite concept scheme
    echo "$scheme"
    uri=$(jq -r .uri $scheme)
    existing=$(curl "${curl_headers[@]}" "${API}voc?uri=$uri" | jq .[])
    # TODO: keep existing API, just add first element!
    json=$(jq --arg API "$API" '.API += [{"url":$API, "type":"http://bartoc.org/api-type/jskos"}]' "$scheme")
    if [ -z "$existing" ]; then
        echo "$json" | curl "${curl_headers[@]}" --json @- "${API}voc" | jq -r .uri
    else
        echo "$json" | curl "${curl_headers[@]}" -X PUT --json @- "${API}voc?uri=$uri" | jq -r .uri
    fi

    # TODO: ggf. vorher alle löschen?
    # curl "${curl_headers[@]}" "${API}concepts?voc=$uri&properties=uri&limit=100" | jq -r .[].uri
    echo 
    echo "$concepts"
    curl "${curl_headers[@]}" -H 'Content-Type: application/x-ndjson' --data-binary "@${concepts}" "${API}concepts?bulk=1&type=ndjson" | jq -r .[].uri 
    echo
}

voc=${2:-}
if [ -n "$voc" ]; then
    import "$voc"
else
    for dir in */; do
        [ -e "$dir/${dir%/}-concepts.ndjson" ] || continue
        import "$dir"
    done
fi
