# lb-ocr
OCR + transliteration on arabic scanned images

Used specifically for Lebanese Government ID card scanned images

# Installation

- clone this repository
- install [jq](https://stedolan.github.io/jq/), curl
- set [Google vision API](https://cloud.google.com/vision/docs/ocr) key into env var `GOOGLE_VISION_API_KEY`
  - get it from google cloud console

# Usage

    ./google-ocr.sh path/to/image.jpg
