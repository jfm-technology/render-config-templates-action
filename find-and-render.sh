#!/bin/bash
set -e

env

TEMPLATE_EXTENSION="$1"
echo "$2" > /variables/vars.json
if [[ -n $3 ]]; then
  cd "$3"
fi

ls -l /variables

RC=0

find -type f -name "*.${TEMPLATE_EXTENSION}" | \
while read template; do
  jinja2 "$template" /variables/vars.json --format=json > "${template%.$TEMPLATE_EXTENSION}"
done
