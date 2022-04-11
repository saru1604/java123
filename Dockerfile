FROM tomcat:8.5.37-jre8
MAINTAINER Sarojini
RUN apt-get update
EXPOSE 8080
ENTRYPOINT ["catalina.sh", "run"]
