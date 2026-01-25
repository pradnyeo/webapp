FROM tomcat:9.0
COPY ./home/ec2-user/webapp/target/WebApp.war /usr/local/tomcat/webapps 
EXPOSE 8080
CMD ["catalina.sh", "run"]
