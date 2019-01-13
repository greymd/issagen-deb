#!/bin/bash
set -e

_THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-${(%):-%N}}")"; pwd)"
_tmpfile="/tmp/latest.json"
curl -f -so- https://api.github.com/repos/greymd/issagen/releases/latest > "${_tmpfile}"
cp "${_THIS_DIR}/issagen-template/debian/changelog" /tmp/changelog

_version=$(cat "${_tmpfile}" | jq -r .tag_name | sed 's/^v//')
_body=$(cat "${_tmpfile}" | jq -r .body | tr -d '\r')

{
echo "issagen (${_version}-1) trusty; urgency=medium"
echo
echo "${_body}" | sed 's/^/  /'
echo
echo " -- Yamada, Yasuhiro <greengregson@gmail.com>  $(date --rfc-2822)"
echo
cat /tmp/changelog
} > "$_THIS_DIR/changelog.new"

mv "$_THIS_DIR/changelog.new" "${_THIS_DIR}/issagen-template/debian/changelog"

rm /tmp/changelog
rm "${_tmpfile}"
