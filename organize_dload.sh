#!/bin/bash


function maybemkdir(){
    if [ ! -d $1 ]; then
        echo "$1 does not exist, creating."
        mkdir $1
    else
        echo "$1 does exist. Nothing to do."
    fi
}

echo "Setting up directories"
maybemkdir "_archives"
maybemkdir "_docs"
maybemkdir "_fonts"
maybemkdir "_software"
maybemkdir "_special"
maybemkdir "_trash"
maybemkdir "_code"
maybemkdir "_license"

#Make these manually
#"~/Pictures/incomming"
#"~/Movies/incomming"
#"~/Music/incomming"


function  moveFile()
{
   if [ ! -e "$1" ] 
     then
       return
     fi
   echo "$1   ==>   $2"
   mv "$1"  "$2"
}


function orgFiles()
{
for fs in $1
do 
   for f in  "$fs"
   do
      moveFile "$f"  "$2"
   done
done
}

orgFiles "download*.html" "./_trash"
orgFiles "*pem *p12 *metadata*.xml *.pcap *cer *side *pub *asc *cert *crt *.rdp *pkpass *.gpg" "./_special"
orgFiles "*pdf *.PDF *txt *log *doc *csv *.xml *docx *pptx *vcf *eml *xls *xlsx *key *.html *htm *ods *.opml" "./_docs"
orgFiles "*pkg *dmg *.iso *gz *tar *tgz *app *.md5 *.sha1 *.sha256 *msi" "./_software"
orgFiles "*zip *rar *bin *trx *ova *img *bz2 *.xz *.tar" "./_archives"
orgFiles "*jpg *JPG *png *PNG *gif *GIF *svg *SVG *.jpeg *JPEG" ~/Pictures/incomming/
orgFiles "*mp4 *MP4 *avi *AVI *mov *MOV" ~/Movies/incomming/
orgFiles "*mp3 *MP3 *m4a *pls" ~/Music/incomming
orgFiles "*stl *gcode *curaplugin" "./_3d"
orgFiles "*woff *ttf *otf" "./_fonts"
orgFiles "*.py *.xml *.json *.hex" "./_code"
orgFiles "*.lic *license" "./_license"

