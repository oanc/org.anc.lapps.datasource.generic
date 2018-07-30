#!/usr/bin/env bash

# Use this script to copy the jar file and ensure the VERSION is
# parsed and passed to the docker build as a `--build-arg`

version=`cat ../../../VERSION`
war=GenericDatasource\#$version.war
args=

echo "Version: $version"
echo "WAR    : $war"
 
if [ "$1" = "--no-cache" ] ; then
	args=--no-cache
fi

if [ ! -e $war ] ; then
	echo "Copying war file."
    cp ../../../target/$war .
fi
echo "Building Docker image"
#docker build $args --build-arg VERSION=$version -t lappsgrid/generic-datasource .
docker build -t lappsgrid/generic-datasource .