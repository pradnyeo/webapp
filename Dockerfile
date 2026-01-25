FROM tomcat:9.0
WORKDIR /usr/local/tomcat/webapps
COPY /home/ec2-user/webapp/target /usr/local/tomcat/webapps 
EXPOSE 8080
CMD ["catalina.sh", "run"]
