#!/usr/bin/env bash

set -x # Show commands
set -eu # Errors/undefined vars are fatal
set -o pipefail # Check all commands in a pipeline

# use what's provided by the environment, but if it's omitted, just assume we're
# on a web-server box and want to process mozilla-central.  (I guess we could
# also just process things based on this script's path?)
INDEX_ROOT=${INDEX_ROOT:-/home/ubuntu/index/mozilla-central}
MOZSEARCH_PATH=${MOZSEARCH_PATH:-/home/ubuntu/mozsearch}

# This script:
# - Runs output-file so that the various files in gecko-docs-overlay are
#   effectively unioned into the mozilla-central source tree if you directly go
#   to a URL.

DOCS_OVERLAY_ROOT=$INDEX_ROOT/gecko-docs-overlay
DOCS_CONFIG_FILE=$DOCS_OVERLAY_ROOT/config.json
# The file to put at the root of the `/mozilla-central/source` URL so that the
# JS UI can load
DOCS_INDEX_FILE=$INDEX_ROOT/file/DOCS-OVERLAY-LIST

pushd docs
git ls-files > $DOCS_INDEX_FILE
DOCS_FILES=$(git ls-files)
popd

$MOZSEARCH_PATH/tools/target/release/output-file $DOCS_CONFIG_FILE mozilla-central $DOCS_FILES
