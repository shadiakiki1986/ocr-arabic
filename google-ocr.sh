#!/bin/bash
#
# Bash script that sends a scanned image to Google Vision API for OCR
# https://cloud.google.com/vision/docs/ocr
#
# Example usage:
#     export GOOGLE_VISION_API_KEY=123456 # or save in /etc/environment
#     ./google-ocr.sh path/to/image
#
#   will output the text to stdout and create a cache path/to/image.json
#
#####################################################

FILE=$1

if [ "$GOOGLE_VISION_API_KEY" == "" ]; then
  echo "missing env var GOOGLE_VISION_API_KEY"
  exit 2
fi

if [ "`which jq`" == "" ]; then
  echo "installing jq   https://stedolan.github.io/jq/"
  wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O /tmp/jq
  sudo mv /tmp/jq /usr/bin/jq
  sudo chmod +x /usr/bin/jq
  echo "done"
fi

if [ "`which curl`" == "" ]; then
  echo "install curl (sudo apt-get install curl)"
  exit 2
fi

if [ "`which base64`" == "" ]; then
  echo "install base64"
  exit 2
fi

if [ "$FILE" == "" ]; then
  echo "pass path to file"
  exit 2
fi

if [ ! -f "$FILE" ]; then
  echo "file does not exist"
  exit 2
fi

if [ ! -f "$FILE.json" ]; then
  URL=https://vision.googleapis.com/v1/images:annotate
  IMAGE_BASE64=`base64 -w 0 "$FILE"`

  # https://stackoverflow.com/questions/16918602/how-to-base64-encode-image-in-linux-bash-shell#16918741
  # https://cloud.google.com/vision/docs/languages
  PAYLOAD='{"requests": [{"image":{"content":"'$IMAGE_BASE64'"}, "imageContext": {"languageHints": ["ar"]}, "features": [{"type": "TEXT_DETECTION"}]}]}'

  echo $PAYLOAD|jq . > /dev/null
  if [ $? -ne 0 ]; then
    echo "Error: invalid json"
    exit 1
  fi

  curl -s -X POST -d @- -o "$FILE.json" -H 'Content-Type: application/json; charset=UTF8' "$URL?key=$GOOGLE_VISION_API_KEY" << CURL_DATA
$PAYLOAD
CURL_DATA
fi

IS_ERR_1=`cat "$FILE.json" |jq ".error" -r`
IS_ERR_2=`cat "$FILE.json" |jq ".responses[0].error" -r`
if [ "$IS_ERR_1" != "null" -o "$IS_ERR_2" != "null" ]; then
  echo "response had error"
  cat "$FILE.json"
  exit 3
fi

#cat "$FILE.json" | jq .responses[0].fullTextAnnotation.text -r|rev > /tmp/f1
#cat "$FILE.json" | jq .responses[0].fullTextAnnotation.text -r|python transliterate.py > /tmp/f2
#paste -d "                            " /tmp/f1 /tmp/f2

cat "$FILE.json" | jq .responses[0].fullTextAnnotation.text -r|python transliterate.py

