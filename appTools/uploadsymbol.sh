#!/bin/bash
bundle_id=$1
fileName=$2
filepath=$3
productVersion=$4

#app_id=e82738941c
#app_key=70127c88-44cb-4998-a20b-6e8717fdfdc3
app_id=$5
app_key=$6

curl -k "https://api.bugly.qq.com/openapi/file/upload/symbol?app_key=${app_key}&app_id=${app_id}" --form "api_version=1" --form "app_id=${app_id}" --form "app_key=${app_key}" --form "symbolType=2"  --form "bundleId=${bundle_id}" --form "productVersion=${productVersion}" --form "channel=tf" --form "fileName=${fileName}" --form "file=@${filepath}" --verbose

