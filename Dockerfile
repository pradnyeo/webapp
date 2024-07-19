FROM tomcat:9.0
WORKDIR /usr/local/tomcat/webapps
RUN curl -o webapp.war http://13.233.212.226:8081/repository/maven-releases/lu/amazon/aws/demo/WebApp/1.0/WebApp-1.0.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
