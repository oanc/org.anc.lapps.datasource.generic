FROM lappsgrid/tomcat7:1.2.0

ARG VERSION
ADD FDR.tgz /var/lib
RUN mv /var/lib/FDR /var/lib/datasource
COPY FDRDataSource\#$VERSION.war /var/lib/tomcat7/webapps
