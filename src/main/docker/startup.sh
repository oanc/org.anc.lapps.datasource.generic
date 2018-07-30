#!/bin/bash

CONF=/var/lib/tomcat7/conf

# Generate a new random admin password every time the server starts.
pw=`cat /dev/urandom | tr -dc _A-Z-a-z-0-9 | head -c${1:-24};echo;`
cat $CONF/tomcat-users-template.xml | sed "s/__PASSWORD__/$pw/" > $CONF/tomcat-users.xml

LOG=/var/log/tomcat7/catalina.out
service tomcat7 start

until [ -e $LOG ] ; do
	sleep 2
done

# Put the tail command in a do-forever loop in case Tomcat rolls the log file.
while :
do
    tail -f $LOG
done