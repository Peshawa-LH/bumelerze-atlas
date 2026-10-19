# Bumelerze Atlas

Computed ground-motion and building-damage products for earthquakes in
Kurdistan and Iraq. Open, versioned and citable.

Produced by the Bumelerze engine (its source is not public) and consumed
by the app at <https://app.bumelerze.com>. Updated by a scheduled sweep,
typically every few hours; not a rapid-response channel.

## Layout

```
index.json                          every event, with its latest version
events/<bml id>/index.json          the versions of that event on the site
events/<bml id>/v<n>/               the products
id-crosswalk.json                   regional-catalogue id -> published id
catalog/                            global earthquake catalogue, M >= 4.5
```

Event ids are Bumelerze ids (`bml` + year + counter). Provider ids are
recorded inside each product as aliases, never as the key. The regional
catalogue numbers its events on its own, so an earthquake can carry a
different id there; `id-crosswalk.json` resolves it to the published one.

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

## Versions

A new version is published when an event's parameters or observations
change, or when the engine does; a published version is not rewritten.
The site keeps only the latest version of every event. Superseded
versions are removed from it and remain in the git history of this
repository.

Every `info.json` records the engine version and the hazard
configuration hash. Risk products also record, in `risk_summary.json`,
the parameter registry and fragility database versions and, from engine
26.2.0, a fingerprint of the risk data. The commit that publishes a
version names the engine release and commit that computed it. Snapshots
of the whole Atlas are tagged `atlas-YYYY-MM-DD`; each tag message
records the engine version, commit and hashes.

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
BY 4.0; OCHA COD-AB Iraq, CC BY-IGO; the IMS-25 vulnerability table.

Building-type estimates come from Bumelerze's own field surveys in Iraq
and the Kurdistan Region, with the GEM Global Exposure Model used as a
reference for areas without survey coverage. Citation: GEM Foundation,
Middle East regional exposure model, Iraq (OpenQuake exposure tables).

Every source and its terms are listed in
[DATA-SOURCES.md](https://github.com/Peshawa-LH/bumelerze-v26/blob/main/DATA-SOURCES.md).

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

An event with a damage report:

> Hasan P. L. (`<year>`) Bumelerze SHAKEmap and damage report, event
> `<bml id>`, version `<n>`, generated `<date>`. Bumelerze Atlas,
> `https://peshawa-lh.github.io/bumelerze-atlas/events/<bml id>/v<n>/`

A hazard-only event:

> Hasan P. L. (`<year>`) Bumelerze shakemap, event `<bml id>`, version
> `<n>`, generated `<date>`. Bumelerze Atlas,
> `https://peshawa-lh.github.io/bumelerze-atlas/events/<bml id>/v<n>/`

The date is `generated_at` in that version's `info.json`. To cite the
Atlas as a whole, name a snapshot tag (`atlas-YYYY-MM-DD`).

Contact: <dev@bumelerze.com>
