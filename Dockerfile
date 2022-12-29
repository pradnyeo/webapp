FROM tomcat:8.0-alpine

LABEL maintainer=”PRADNYESH”

ADD WebApp.war /usr/local/tomcat/webapps/

EXPOSE 8080
CMD chmod +x /usr/local/tomcat/bin/catalina.sh
CMD ["catalina.sh", "run"]
