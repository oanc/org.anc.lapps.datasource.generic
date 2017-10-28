#FROM lappsgrid/tomcat7:1.2.3
FROM tomcat:9.0.1-jre8-alpine
ARG VERSION
#COPY GenericDatasource*.war /var/lib/tomcat7/webapps
COPY GenericDatasource*.war /usr/local/tomcat/webapps
COPY context.xml /usr/local/tomcat/webapps/manager/META-INF
COPY tomcat-users-template.xml /usr/local/tomcat/conf
COPY startup.sh /usr/local/bin
RUN chmod +x /usr/local/bin/startup.sh

CMD ["/usr/local/bin/startup.sh"]
