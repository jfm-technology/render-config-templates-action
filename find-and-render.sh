#!/bin/bash
set -e

TEMPLATE_EXTENSION="$1"
echo "$INPUT_VARS" > /variables/vars.json
if [[ -n $2 ]]; then
  cd "$2"
fi

RC=0

find -type f -name "*.${TEMPLATE_EXTENSION}" | \
while read template; do
  echo "::debug::Processing template file $template"
  jinja2 "$template" /variables/vars.json --format=json > "${template%.$TEMPLATE_EXTENSION}"
  if [[ $3 = 'true' ]]; then
    rm -f "$template"
  fi
done
