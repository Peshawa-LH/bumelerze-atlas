#!/usr/bin/env bash
# Assembles the published Atlas in _site/: the products (events/), the bulk
# catalogs (catalog/), the two index files, README and LICENSE, plus the
# response headers for Cloudflare Pages (site/_headers). Nothing else in this
# repository is published (worker state, workflows, scripts stay private to
# the repo).
#
# Cloudflare Pages project `bumelerze-atlas` (atlas.bumelerze.com, B2.4,
# 2026-11) runs this as its build command, output directory `_site`, on every
# push to main. The GitHub Pages copy (.github/workflows/deploy-pages.yml)
# assembles the same tree without _headers while old links still point there.
set -euo pipefail
cd "$(dirname "$0")/.."
rm -rf _site
mkdir -p _site
cp -r events _site/events
cp -r catalog _site/catalog
cp index.json id-crosswalk.json README.md LICENSE _site/
cp site/_headers _site/_headers
echo "assembled _site: $(find _site -type f | wc -l | tr -d ' ') files, $(du -sh _site | cut -f1)"
