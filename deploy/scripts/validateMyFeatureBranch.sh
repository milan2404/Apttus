#!/bin/bash
#sh deploy/scripts/validateMyFeatureBranch.sh
rm -Rf "deploy/temp"
cd deploy
cd scripts
#sh install_Plugins.sh
#sh createPackage.sh -b origin/prod
sh createPackage.sh -b origin/master
sh buildProfiles.sh
sh createManifest.sh
sh fetchTestClasses.sh
cd ..
cd ..

#validate
#sfdx force:source:deploy --checkonly --targetusername TEMSA002 --wait 9999 --manifest deploy/temp/package.xml --predestructivechanges force-app/main/default/destructiveChangesPre.xml --postdestructivechanges force-app/main/default/destructiveChangesPost.xml  --testlevel RunSpecifiedTests --runtests $(<deploy/temp/testsToRun.txt)

sfdx force:source:deploy --checkonly --targetusername CongaBilling001 --wait 9999 --manifest deploy/temp/package.xml --predestructivechanges force-app/main/default/destructiveChangesPre.xml --postdestructivechanges force-app/main/default/destructiveChangesPost.xml  --testlevel RunSpecifiedTests --runtests $(<deploy/temp/testsToRun.txt)
#sfdx force:source:deploy --checkonly --targetusername SANDBOXName --wait 9999 --manifest deploy/temp/package.xml --predestructivechanges force-app/main/default/destructiveChangesPre.xml --postdestructivechanges force-app/main/default/destructiveChangesPost.xml  --testlevel RunSpecifiedTests --runtests $(<deploy/temp/testsToRun.txt)

rm -Rf "deploy/temp"
