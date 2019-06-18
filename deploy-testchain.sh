#!/usr/bin/env bash

# shellcheck source=lib/common.sh
. "${LIB_DIR:-$(cd "${0%/*}/lib"&&pwd)}/common.sh"
setConfigFile "testchain"

export CASE="$LIBEXEC_DIR/cases/$1"

[[ $# > 0 && ! -f "$CASE" ]] && exit 1

# Send ETH to Omnia Relayer
export OMNIA_RELAYER=$(jq -r ".omniaFromAddr" "$CONFIG_FILE")
seth send "$OMNIA_RELAYER" --value "$(seth --to-wei 10000 eth)"

"$LIBEXEC_DIR"/base-deploy

if [[ -f "$CASE" ]]; then
    echo "TESTCHAIN DEPLOYMENT + ${1} COMPLETED SUCCESSFULLY"
else
    echo "TESTCHAIN DEPLOYMENT COMPLETED SUCCESSFULLY"
fi