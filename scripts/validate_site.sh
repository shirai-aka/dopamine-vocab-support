#!/bin/sh
set -eu

expected_name='ドーパミン英単語'
expected_bundle='com.shirai.dopaminevocab'
forbidden_names='論理の塔 ドーパミン電卓 LOGIC'

files='index.html support/index.html privacy-policy/index.html'

for file in $files; do
  test -f "$file"
  grep -Fq "$expected_name" "$file"
  for forbidden in $forbidden_names; do
    if grep -Fq "$forbidden" "$file"; then
      echo "ERROR: 別アプリ名が含まれています: $file ($forbidden)" >&2
      exit 1
    fi
  done
done

grep -Fq "$expected_name" site-identity.json
grep -Fq "$expected_bundle" site-identity.json
grep -Fq '外部SDKも利用していません' privacy-policy/index.html
grep -Fq '広告を表示せず' privacy-policy/index.html
grep -Fq 'App Tracking Transparency' privacy-policy/index.html
grep -Fq 'ローカル通知' privacy-policy/index.html

echo 'SITE_VALIDATION_PASS / DOPAMINE VOCAB / 3 PAGES'
