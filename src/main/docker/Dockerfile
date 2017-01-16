FROM lappsgrid/tomcat7:1.2.0

ARG VERSION
ADD FDR.tgz /var/corpora/
COPY FDRDatasource\#$VERSION.war /var/lib/tomcat7/webapps
