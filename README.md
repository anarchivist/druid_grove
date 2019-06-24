druid_grove
===========

Creates a IIIF Presentation API 2.1 Collection out of Stanford Digital Repository collection objects. druid_grove takes one argument as an environment variable: `DRUID` for the collection object DRUID you wish to fetch.

This only works on the Stanford network, and only works for public or Stanford-only objects.

```bash
DRUID=kx532cb7981 druid_grove.sh
```

It depends on `jq`, `curl`, and `bash`.

FAQ
---

* Why is it called `druid_grove`?
  - Contemporary druids are organized in groups called [groves](https://www.druidry.org/community/groves-groups).
  - Objects in the Stanford Digital Repository have unique identifiers called DRUIDs.
