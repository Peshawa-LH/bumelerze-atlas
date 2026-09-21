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

## License and attribution

The Atlas itself is licensed [CC BY 4.0](LICENSE): Bumelerze Atlas,
Peshawa L. Hasan. Products are built from upstream data that carries its
own terms, and those terms require attribution wherever these products are
used or redistributed.

**Hazard products** (`grid.json`, `cont_mi.json`, `bands_mi.json`,
`info.json`) come from earthquake source parameters published by **USGS**,
**EMSC** and **GEOFON**, from USGS finite-fault and observation products
where published, and from a site-condition grid derived from the **USGS**
global Vs30 slope proxy.

**Risk products** (`damage_grid.json`, `cont_damage.json`,
`bands_damage.json`, `districts.json`, `areas.json`, `risk_summary.json`,
`report.pdf`) additionally derive from:

| Source | Licence | Attribution required |
| --- | --- | --- |
| GFZ OpenBuildingMap building footprints | ODbL 1.0 (share-alike) | © OpenStreetMap contributors |
| Microsoft Building Footprints | CDLA-Permissive-2.0 | Microsoft |
| GHS-BUILT-S and GHS-SMOD, GHS Urban Centre Database | CC BY 4.0 | European Commission JRC |
| WorldPop population, Iraq 2025 | CC BY 4.0 | WorldPop, University of Southampton |
| OCHA COD-AB Iraq administrative boundaries | CC BY-IGO | OCHA FISS / ITOS; Iraq Central Statistics Office |
| Iraq 2024 census tables | Iraqi government publication, terms not stated | Central Statistical Organisation; Kurdistan Region Statistics Office |
| GEM Middle East exposure model | not confirmed | GEM Foundation |

### One licensing question is open

The building stock behind every risk product descends from
OpenStreetMap through OpenBuildingMap, and **ODbL 1.0 is share-alike**. It
distinguishes a *Derivative Database*, which must itself be offered under
ODbL, from a *Produced Work* rendered from a database, which may be
licensed freely provided the database and its licence are credited.

Which of the two a given risk product is depends on the product, and this
has not been settled:

- `damage_grid.json` is per-cell and is the closest thing here to a
  database of its own; the conservative reading treats it as a Derivative
  Database.
- The area aggregates (`areas.json`, `districts.json`,
  `risk_summary.json`) and the contour and band geometries are statistics
  and renderings, which read more naturally as Produced Works.

Until the owner rules on it, the safe assumption for a reuser is that the
risk products carry ODbL obligations, and the attribution above must
travel with them either way. The hazard products are unaffected: nothing
in them derives from OpenStreetMap.

Contact: <hello@bumelerze.com>
