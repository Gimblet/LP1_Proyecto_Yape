FROM tomcat:9.0-jdk17-temurin-noble
EXPOSE 8888:8080
RUN cd /usr/local/tomcat/webapps/ mkdir Yape
WORKDIR /usr/local/tomcat/webapps/Yape
COPY target/Yape-latest/ .