#!/bin/bash
#sh createManifest.sh
cd ..
mkdir -p temp/
rm -f temp/package.xml

sfdx force:source:manifest:create --sourcepath src/ --manifestname "temp/package.xml"

echo '##################################'
echo '# predestructivechanges'
cat ../force-app/main/default/destructiveChangesPre.xml

echo '##################################'
echo '# packge'
cat temp/package.xml

echo '##################################'
echo '# postdestructivechanges'
cat ../force-app/main/default/destructiveChangesPost.xml
echo '##################################'
