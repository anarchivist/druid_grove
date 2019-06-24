#! /usr/bin/env bash

# TODO: Create paged IIIF collections to handle collections with > 10000 objects

collinfo=$(curl -sH 'Accept: application/json' \
  https://searchworks.stanford.edu/view/$DRUID | \
  jq -r --arg DRUID "$DRUID" '.response.document | {
    "@context": "http://iiif.io/api/presentation/2/context.json",
    "@id": ("https://sul-dlss-labs/iiif-collections/" + $DRUID + ".json"),
    "@type": "sc:Collection",
    "label": (.["title_full_display"]),
    "description": (.["summary_display"][0]),
    "seeAlso": ("https://purl.stanford.edu/" + $DRUID)
  }')

curl -s "https://purl-fetcher.stanford.edu/collections/druid:$DRUID/purls?per_page=10000" | jq -r --arg collinfo "$collinfo" '(($collinfo | fromjson) + {
  "manifests": [.purls[] |
    {
      "@id": ("https://purl.stanford.edu/" + (.["druid"] | split(":")[1]) + "/iiif/manifest"),
      "@type": "sc:Manifest",
      "label": (.["title"])
    }
  ]
})'
