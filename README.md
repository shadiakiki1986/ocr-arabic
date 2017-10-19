# lb-ocr
OCR + transliteration on arabic scanned images

Used specifically for Lebanese Government ID card scanned images

# Installation

- clone this repository
- install [jq](https://stedolan.github.io/jq/), curl, [direnv](https://direnv.net/)
- copy `.envrc.dist` to `.envrc` and set [Google vision API](https://cloud.google.com/vision/docs/ocr) key into env var `GOOGLE_VISION_API_KEY`
  - get it from google cloud console
- `direnv allow .` 

# Usage

Download example scanned ID

    wget https://www.tradearabia.com/source/2014/08/06/id.jpg -O images/id.jpg

Run OCR and transliteration

    ./ocr-arabic.sh images/id.jpg

Example input

![example scanned ID](https://www.tradearabia.com/source/2014/08/06/id.jpg)

Example output

    Transliterated                          |                                     OCR
    ---------------------------------------------------------------------------------
    United Arab Emirates o                  |                  o setarimE barA detinU
    . ldentity card                         |                         drac ytitnedl .
    dwlp Al<mArAt AlErbyp AlmtHdp           |ةدحتملا ةيبرعلا تارامإلا ةلود
    bTAqp hwyp                              |                     ةيوه ةقاطب
    Number                                  |                                  rebmuN
    rqm Alhwyp / ID                         |                DI / ةيوهلا مقر
    784-1977-1234566-1                      |                      1-6654321-7791-487
    mn Al<sm: AHmd mHmd Ebd Allh            |هللا دبع دمحم دمحا :مسإلا نم
    Name: Ahmed Mohamed Abdulla             |             alludbA demahoM demhA :emaN
    Aljnsyp: Al<mArAt AlErbyp AlmtHdp       |ةدحتملا ةيبرعلا تارامإلا :ةيسنجلا
    Nationality: United Arab Emirates       |       setarimE barA detinU :ytilanoitaN
    
