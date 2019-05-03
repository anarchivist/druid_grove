druid_grove
===========

Creates a IIIF Presentation API 2.1 Collection out of Stanford Libraries catkeys. druid_grove takes two arguments as environment variables: `$CATKEY` (the catkey you want) and `$INFILE` (a JSON file dumped from Argo's Solr index)

```bash
CATKEY=1234567 INFILE=select.json druid_grove.sh
```

It depends on `jq`, `curl`, and `bash`.

FAQ
---

* Why is it called `druid_grove`?
  - Contemporary druids are organized in groups called [groves](https://www.druidry.org/community/groves-groups).
  - Objects in the Stanford Digital Repository have unique identifiers called DRUIDs.
