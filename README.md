# Bumelerze Atlas

Computed ground-motion and building-damage products for earthquakes in
Kurdistan and Iraq. Open, versioned and citable.

Produced by the [Bumelerze engine](https://github.com/Peshawa-LH/bumelerze-engine)
and consumed by the app at <https://bumelerze.com>.

## Layout

```
index.json                          every event, with its latest version
events/<bml id>/index.json          every version of that event
events/<bml id>/v<n>/               the products
catalog/                            global earthquake catalogue, M >= 4.5
```

Event ids are Bumelerze ids (`bml` + year + counter). Provider ids are
recorded inside each product as aliases, never as the key.

## Products

| File | What it is |
| --- | --- |
| `grid.json` | PGA, PGV, SA(0.3), SA(1.0), IMS-25 intensity, MMI, and their sigmas. **The authoritative field** |
| `cont_mi.json` | Intensity contour lines |
| `bands_mi.json` | Intensity as filled polygons, holes included |
| `info.json` | The earthquake, the engine chain, the data used, versions, review status |
| `damage_grid.json` | Per cell: expected damage grade, buildings at DG3+, exposed population |
| `cont_damage.json`, `bands_damage.json` | The same line and fill pair for damage |
| `areas.json` | Damage by governorate, district, sub-district and city |
| `districts.json` | Governorate damage, the older single-level form |
| `risk_summary.json` | National totals, settings, provenance |
| `report.pdf` | Three-page report |

Risk products exist only where the exposure model does, which is Iraq.
Events outside it are published shakemap-only, and say so.

Every product records the engine version, the configuration hash, the
parameter registry version and the fragility database version, so any
number can be traced to the code and settings that produced it.

## Review status

Every version carries `review_status`: `automatic` for a product the
engine published unattended, `reviewed` once a scientist has signed it
off. Check it before relying on a number.

## Licence and attribution

The Atlas is [CC BY 4.0](LICENSE): Bumelerze Atlas, Peshawa L. Hasan.

Products are built from upstream data whose licences require credit, and
that credit travels with them: USGS, EMSC and GEOFON earthquake
parameters; building footprints from GFZ OpenBuildingMap, derived from
OpenStreetMap, © OpenStreetMap contributors, ODbL, and from Microsoft,
CDLA-Permissive-2.0; JRC Global Human Settlement Layer and WorldPop, CC
BY 4.0; OCHA COD-AB Iraq, CC BY-IGO; GEM Global Exposure Model; the
IMS-25 vulnerability table. Full records, with licences and checksums,
are in the engine repository.

**One question is unsettled.** The building stock descends from
OpenStreetMap under ODbL, which is share-alike. ODbL separates a
*Derivative Database*, which must itself be offered under ODbL, from a
*Produced Work* rendered from one, which need not be. Which a given risk
product is has not been ruled on: `damage_grid.json` is per-cell and
reads as the former, while the area aggregates and the contour geometries
read as the latter. Until it is settled, assume the risk products carry
ODbL obligations. The hazard products are unaffected, since nothing in
them derives from OpenStreetMap.

## Citing

> Hasan P. L. (2026) Bumelerze SHAKEmap and damage report, event
> `<bml id>`, version `<n>`.

Contact: <dev@bumelerze.com>
