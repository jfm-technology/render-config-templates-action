#!/bin/bash
set -e

pwd
ls -ls

cd "$1"
TEMPLATE_EXTENSION="$2"
echo "$3" > /variables/vars.json

ls -l /variables

RC=0

find -type f -name "*.${TEMPLATE_EXTENSION}" | \
while read template; do
  echo "$template"
  jinja2 "$template" /variables/vars.json --format=json > "${template%.$TEMPLATE_EXTENSION}"
done
