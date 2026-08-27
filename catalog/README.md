# Bumelerze catalog — global earthquakes, M ≥ 4.5

`global-m45.parquet` is every earthquake of magnitude 4.5 or greater that
the USGS catalogue holds, from 1900 to 27 August 2026. It is the global
backdrop for the Bumelerze map: uniform worldwide coverage at a threshold
that actually holds everywhere.

| | |
| --- | --- |
| Events | **310,627** |
| Period | 1900-01-05 → 2026-08-26 |
| Magnitude | 3.4 – 9.5 |
| Threshold | M ≥ 4.5, no upper bound |
| Format | Apache Parquet, zstd level 19 |
| Size | **4.4 MB** (14.0 bytes per event) |
| Source | USGS FDSN `event/1/query`, fetched 27 August 2026 |

## Why 4.5 and not lower

USGS completeness below roughly M4.5 is not uniform: it is dominated by
dense national networks. A magnitude 2.5 in Oklahoma is catalogued; a
magnitude 2.5 in Kurdistan is not. Bumelerze measured this — over
2024–2026 in the Kurdistan box at M ≥ 3, the ISC bulletin holds 162 events
where USGS holds 38. Published at M2.5, a world map would render as a thick
clot over the United States and near-emptiness elsewhere, which a reader
reasonably mistakes for a broken map rather than for what it is, an
artifact of where the seismometers are.

M4.5 is the threshold at which global coverage is genuinely uniform, so it
is the threshold this file uses. Dense local coverage is a separate
product: the Kurdistan and Iraq catalog carries every magnitude, down to
M0.4, because local networks there make that honest.

## Columns

| Column | Type | Notes |
| --- | --- | --- |
| `usgs_id` | string | USGS event id, e.g. `us7000tbta`. The primary key. |
| `bumelerze_id` | string, nullable | Set only where the event is also in the Bumelerze Kurdistan/Iraq catalog, in which case both carry the same id. Null for the rest — see Identifiers. |
| `time` | timestamp[ms, UTC] | Origin time. |
| `latitude`, `longitude` | float32 | Epicentre. float32 resolves to about a metre, an order of magnitude finer than the best location in the file. |
| `depth_km` | float32 | Nullable. |
| `magnitude` | float32 | |
| `magnitude_type` | dictionary | `mb`, `mw`, `ms`, `ml`, … Not homogenized; each is what the source published. |
| `network` | dictionary | Contributing network code. |
| `location_source` | dictionary | Which agency located the event. |
| `magnitude_source` | dictionary | Which agency supplied the magnitude. |
| `review_status` | dictionary | `reviewed` or `automatic`. |

Only `type = earthquake` rows are included. Explosions, quarry and mining
blasts, ice quakes and other non-tectonic entries in the USGS catalogue are
excluded, because a map that plots a nuclear test as an earthquake
misinforms its reader. Excluded in this build: 614 nuclear explosion, 71 volcanic eruption, 16 explosion, 6 mine collapse, 3 rock burst, 3 landslide, 1 other event, 1 quarry blast.

1 event(s) in this file carry a magnitude below 4.5. USGS filters the query on the event's preferred magnitude at index time; a magnitude later revised downward stays in the result set. They are kept rather than silently dropped, so that this file is exactly what the query returned.


## Identifiers

Bumelerze event ids (`bml` + origin year + base-36 counter) are allocated
once, at first detection, by a single writer, and are immutable. This file
therefore does not mint them. It carries the id where the same physical
earthquake already has one in the Kurdistan/Iraq catalog — matched at
16 seconds, 100 km and 1.5 magnitude units, the same thresholds that
catalog uses internally — and leaves it null everywhere else.
1,613 of 310,627 events carry one.

That number is small on purpose. Only 1,612 of these global events fall
inside the Kurdistan/Iraq bounding box at all, and 100 % of those
do match. The Kurdistan catalog holds considerably more events at M ≥ 4.5
than appear here, because its magnitudes come from local networks and are
often a different magnitude type — an event at local M4.8 can sit below
4.5 on the USGS preferred magnitude and so is absent from this file. Neither
catalog is wrong; they are measuring with different instruments and this
file does not homogenize them.

## Regenerating

From the Bumelerze engine repository:

```
./.venv/bin/python scripts/build_global_catalog.py
```

Responses are cached under `.cache/fdsn/`, so a re-run costs nothing at the
USGS end; delete that directory to force a refresh. The build fetches in
one-year windows (USGS refuses any single query matching more than 20 000
events), sequentially and with a delay between requests.

`--offline` replays the cache and refuses to touch the network.

## Provenance and terms

Earthquake parameters are from the U.S. Geological Survey's National
Earthquake Information Center, via the FDSN event web service. USGS
catalogue data are in the public domain; the compilation, its threshold and
its identifiers are Bumelerze's. See `DATA-SOURCES.md` in the main
repository for the full terms of every source Bumelerze uses.
