# Bumelerze Atlas

Computed ground-motion and risk products for earthquakes in Kurdistan and Iraq,
published as open, versioned, citable data.

Every product here was produced by the Bumelerze SHAKEmap engine
(`shake-service` in the [main repository](https://github.com/Peshawa-LH/bumelerze-v26))
and is consumed by the Bumelerze app at <https://bumelerze.com>.

## What is in here

| Path | Contents |
| --- | --- |
| `index.json` | Catalogue of every event, with its latest version |
| `events/<event-key>/index.json` | Every published version of that event, with full provenance |
| `events/<event-key>/v<N>/cont_mi.json` | Intensity contours, GeoJSON, the primary artifact |
| `events/<event-key>/v<N>/info.json` | Product metadata for that version |
| `catalog/global-m45.parquet` | Every earthquake worldwide at M ≥ 4.5, 1900 to now — see `catalog/README.md` |

Products are **vector first**. The primary artifacts are GeoJSON contours and
JSON metadata, so the app draws them as live map layers rather than as flat
images, and so anyone can query, restyle, or reanalyse them. Raster grids are
published only where a gridded field is genuinely needed, and are never
required to display a map.

## Provenance and review status

Every product carries the configuration that produced it: engine version,
ground-motion models and their weights, the intensity conversion used, the
conditioning method, and which observational data were available (station
records, felt reports, finite-fault rupture models).

Products also carry a **review status**. Automatically computed products are
published as provisional. A product marked as reviewed has been checked by a
seismologist. Provisional products are published rather than hidden, because a
map that states its own uncertainty is more useful than a missing one.

Science is corrected over time. When the engine is fixed, affected products are
recomputed and republished as a new version. Superseded versions remain in this
repository's history, so the record of what was shown, and when, is preserved.

## Identifiers

Events are keyed by Bumelerze event id (`bml` + origin year + a base-36
counter, for example `bml2017000s`). Agency identifiers from USGS, EMSC, and
GEOFON are recorded inside each product's metadata, so a product can always be
traced back to the source catalogues.

## Using the data

Products are served over HTTPS from this repository and may be fetched
directly. Please cite the Atlas if you use it in published work, and check each
product's review status before relying on it.

## License

Data and products in this repository are licensed under
[CC BY 4.0](LICENSE). Attribution: Bumelerze Atlas, Peshawa L. Hasan.
Products are derived from earthquake parameters published by USGS, EMSC, and
GEOFON, which carry their own terms; see
[DATA-SOURCES.md](https://github.com/Peshawa-LH/bumelerze-v26/blob/main/DATA-SOURCES.md)
in the main repository.

Contact: <hello@bumelerze.com>
