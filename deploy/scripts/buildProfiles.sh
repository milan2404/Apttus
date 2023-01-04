#!/bin/bash
#sh buildProfiles.sh
cd ..

mkdir -p temp
rm -f temp/profiles.txt
touch temp/profiles.txt

mkdir -p src/force-app/main/default/profiles
ls "src/force-app/main/default/profiles" > temp/profiles.txt

#Copy json file for profile if not copied as part of delta
while read profileName; do
    mkdir -p "src/force-app/main/default/profiles/${profileName}" && cp "../force-app/main/default/profiles/${profileName}/${profileName}.json" "src/force-app/main/default/profiles/${profileName}/${profileName}.json"
done <temp/profiles.txt

cd src

echo "building profiles"
while read profileName; do
    sfdx dxb:profile:build -p "${profileName}" || exit 1
    cp "force-app/main/default/profiles/${profileName}.profile-meta.xml" "../../force-app/main/default/profiles"
done < "../temp/profiles.txt"
