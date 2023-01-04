#!/bin/bash
#sh install_Plugins.sh
cd ..
cd ..
echo y | sfdx plugins:install dxb@latest
sfdx config:set restDeploy=true
