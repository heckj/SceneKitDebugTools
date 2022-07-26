#!/bin/bash

set -e
set -x

rm -rf html
mkdir -p html

rm -rf .build
mkdir -p .build/symbol-graphs

# Enables deterministic output
# - useful when you're committing the results to host on github pages
export DOCC_JSON_PRETTYPRINT=YES

swift build --target SceneKitDebugTools \
-Xswiftc -emit-symbol-graph \
-Xswiftc -emit-symbol-graph-dir -Xswiftc .build/symbol-graphs

# cull the non-Lindenmayer specific builds from the symbol graph files
rm -f .build/symbol-graphs/MeshGenerator*

# run the analysis process to report on the docs status
xcrun docc convert Sources/SceneKitDebugTools/Documentation.docc \
--analyze \
--fallback-display-name SceneKitDebugTools \
--fallback-bundle-identifier com.github.heckj.SceneKitDebugTools \
--fallback-bundle-version 0.1.0 \
--additional-symbol-graph-dir .build/symbol-graphs \
--experimental-documentation-coverage \
--level brief

#xcrun docc convert Sources/SceneKitDebugTools/Documentation.docc \
#--enable-inherited-docs \
#--output-path html \
#--fallback-display-name SceneKitDebugTools \
#--fallback-bundle-identifier com.github.heckj.SceneKitDebugTools \
#--fallback-bundle-version 0.1.0 \
#--additional-symbol-graph-dir .build/symbol-graphs \
#--transform-for-static-hosting \
#--hosting-base-path '/' \
#--emit-digest

# Swift package plugin for hosted content:
#
swift package \
    --allow-writing-to-directory ./docs \
    --target SceneKitDebugTools \
    generate-documentation \
    --output-path ./docs \
    --emit-digest \
    --disable-indexing \
    --transform-for-static-hosting \
    --hosting-base-path 'SceneKitDebugTools'

#
# Generate a list of all the identifiers for DocC curation
#

cat docs/linkable-entities.json| jq '.[].referenceURL' -r > all_identifiers.txt
sort all_identifiers.txt | sed -e 's/doc:\/\/SceneKitDebugTools\/documentation\///g' \
| sed -e 's/^/- ``/g' | sed -e 's/$/``/g' > all_symbols.txt

echo "Page will be available at https://heckj.github.io/SceneKitDebugTools/documentation/scenekitdebugtools/"
