#!/bin/bash
#sh fetchTestClasses.sh
cd ..
rm -f temp/testSuites.txt
touch temp/testSuites.txt

rm -f temp/testsToRun.txt
touch temp/testsToRun.txt

rm -f temp/testClassTemp1.txt
touch temp/testClassTemp1.txt

rm -f temp/testClassTemp2.txt
touch temp/testClassTemp2.txt

mkdir -p src/force-app/main/default/classes
mkdir -p src/force-app/main/default/triggers
mkdir -p src/force-app/main/default/flows

ls src/force-app/main/default/classes >> temp/testSuites.txt
ls src/force-app/main/default/triggers >> temp/testSuites.txt
ls src/force-app/main/default/flows >> temp/testSuites.txt

cd ..

while IFS="" read -r p || [ -n "$p" ]; do
    fileName="$(basename $p)"
    testSuiteName="${fileName%%.*}"
    FILE="force-app/main/default/testSuites/$testSuiteName.testSuite-meta.xml"
    if [ -e $FILE ]; then
        awk -F "[><]" '/testClassName/{print $3}' $FILE >>deploy/temp/testClassTemp1.txt
        echo "," >>deploy/temp/testClassTemp1.txt
    fi
done <deploy/temp/testSuites.txt

echo "SampleTest" >>deploy/temp/testClassTemp1.txt
echo "SampleTest" >>deploy/temp/testClassTemp1.txt

awk 'length > 1' deploy/temp/testClassTemp1.txt >>deploy/temp/testClassTemp2.txt
sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/,/g' deploy/temp/testClassTemp2.txt >deploy/temp/testsToRun.txt

echo "6. Test classes to run:"
cat deploy/temp/testsToRun.txt
