#!/usr/bin/env bash

# Use this script to copy the jar file and ensure the VERSION is
# parsed and passed to the docker build as a `--build-arg`

version=`cat ../../../VERSION`
war=FDRDataSource\#$version.war
args=

if [ "$1" = "--no-cache" ] ; then
	args=--no-cache
fi

if [ ! -e $war ] ; then
    echo "Copying war file"
    cp ../../../target/$war .
fi

if [ ! -e FDR.tgz ] ; then
    wget http://downloads.lappsgrid.org/FDR.tgz
fi

docker build $args --build-arg VERSION=$version -t lappsgrid/fdr-datasource .
