FROM tomcat:8.0
COPY ./target/WebApp.war /usr/local/tomcat/webapps/
