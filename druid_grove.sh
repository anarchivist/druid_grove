#! /usr/bin/env bash

collinfo=$(curl -H 'Accept: application/json' \
  https://searchworks.stanford.edu/view/$CATKEY | \
  jq -r --arg CATKEY "$CATKEY" '.response.document | {
    "@context": "http://iiif.io/api/presentation/2/context.json",
    "@id": "https://example.com/iiifcollection.json",
    "@type": "sc:Collection",
    "label": (.["title_full_display"]), "description": (.["summary_display"][0]),
    "seeAlso": (.["managed_purl_urls"][0])
  }')

druid=$(jq -r --arg collinfo "$collinfo" '$collinfo | fromjson | .seeAlso | split(".edu/")[1]')

# $INFILE is created from the following, but up rows as needed https://sul-solr-c/solr/argo3_prod/select?fl=id,sw_display_title_tesim&q=is_member_of_collection_ssim%3A"info%3Afedora%2Fdruid%3A$druid"&wt=json&rows=17000

cat $INFILE | jq -r --arg collinfo "$collinfo" '(($collinfo | fromjson) + {
  "manifests": [.response.docs[] |
    {
      "@id": ("https://purl.stanford.edu/" + (.["id"] | split(":")[1]) + "/iiif/manifest"),
      "@type": "sc:Manifest",
      "label": .sw_display_title_tesim[0]
    }
  ]
})'
