# lb-ocr
OCR using google vision API on Lebanese Government ID card + transliteration

# Installation

- clone this repository
- install jq
- set Google vision API key into env var `GOOGLE_VISION_API_KEY`
  - https://cloud.google.com/vision/docs/ocr
  - get it from google cloud console

# Usage

    ./google-ocr.sh path/to/image.jpg
