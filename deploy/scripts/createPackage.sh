#!/bin/bash
#sh scripts/createPackage.sh -b origin/prod
cd ..
while getopts b:r:a:u: option; do
    case "${option}" in
    b) BNAME=${OPTARG} ;;
    esac
done

rm -Rf src

mkdir -p temp
rm -Rf temp/modifiedFiles.txt
touch temp/modifiedFiles.txt

#get list of all modified files by comparing to main branch
git diff --minimal --no-renames --no-commit-id --name-only --diff-filter=ACMRTUXB --patch $BNAME ../force-app/main/default >>temp/modifiedFiles.txt
echo "force-app/main/default/classes/SampleTest.cls" >>temp/modifiedFiles.txt

#copy all modified files to src folder to generate manifest(Package.xml)
while read c; do
    echo "$c" >>temp/modifiedFiles2.txt
    if
        [[ $c == *force-app/main/default/classes/* ]] || [[ $c == *force-app/main/default/triggers/* ]] || [[ $c == *force-app/main/default/components/* ]] || [[ $c == *force-app/main/default/pages/* ]]
    then
        if [[ $c == *-meta.xml ]]; then
            echo $c | sed 's/-meta.xml//' >>temp/modifiedFiles2.txt
        else
            echo "$c-meta.xml" >>temp/modifiedFiles2.txt
        fi
    fi

    if
        [[ $c == *force-app/main/default/aura/* ]] || [[ $c == *force-app/main/default/lwc/* ]] || [[ $c == *force-app/main/default/staticresources/* ]]
    then
        rm -f temp/tempFileName.txt
        folderPath=${c%/*}
        ls ../$folderPath >temp/tempFileName.txt
        while read d; do
            echo "$folderPath/$d" >>temp/modifiedFiles2.txt
        done <temp/tempFileName.txt
        rm -f temp/tempFileName.txt
    fi
done <temp/modifiedFiles.txt

#copy all modified files to src folder to generate manifest(Package.xml)
while read c; do
    ROOT=${c%/*}
    mkdir -p "src/$ROOT" && cp "../$c" "src/$c"
done <temp/modifiedFiles2.txt
