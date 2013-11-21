#!/bin/sh

# Automate creation of neuroConstruct/CElegansNeuroML bundle.
#
# Run this script from the OpenwormConnectomeBundle directory.
# It will download the components of the bundle, and create a
# zip file of the bundle in the OpenwormConnectomeBundle dir.

DATE=`date +%Y%m%d`

# Create bundle directory
BUNDLE_DIR_NAME=OpenwormConnectomeBundle-snapshot-$DATE
mkdir $BUNDLE_DIR_NAME
cd $BUNDLE_DIR_NAME

# Get neuroConstruct
git clone git://github.com/NeuralEnsemble/neuroConstruct.git
cd neuroConstruct
./updatenC.sh

# Modify neuroConstruct install scripts
sed -i "s/\$HOME\/neuroConstruct/export NC_HOME=\$(dirname \$0)/" nC.sh
sed -i "s/set NC_HOME=C:\\neuroConstruct/set NC_HOME=%~dp0/" nC.bat

# Copy README and scripts to bundle directory
cd ..
cp ../setup.sh ../setup.bat ../README.txt .
chmod 754 setup.sh

# Set dates in README
sed -i "s/{{DATE}}/$DATE/" README.txt

# Get CElegansNeuroML
git clone git://github.com/openworm/CElegansNeuroML.git

# Create zip file of bundle directory
cd ..
zip -r $BUNDLE_DIR_NAME $BUNDLE_DIR_NAME

# Clean up
rm -rf $BUNDLE_DIR_NAME