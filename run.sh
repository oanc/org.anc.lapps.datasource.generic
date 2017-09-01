#!/usr/bin/env bash

v1=`pwd`/target:/var/lib/tomcat7/webapps
v2=/private/var/corpora/BIONLP2016-LIF/bionlp-st-ge-2016-coref:/var/lib/datasource 
VOLUMES="-v $v1 -v $v2"
docker run -d -p 8080:8080 $VOLUMES --name datasource lappsgrid/generic-datasource:1.1.0


