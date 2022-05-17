ARG SERVER_NAME
FROM $SERVER_NAME.jfrog.io/su-114-docker-virtual/openjdk:11-jdk

COPY target/apache-tomcat-8.0.32.tar.gz /home/exec/tomcat/apache-tomcat-8.0.32.tar.gz
RUN cd /home/exec/ && tar -xvf /home/exec/tomcat/apache-tomcat-8.0.32.tar.gz
ADD tomcat/server.xml /home/exec/apache-tomcat-8.0.32/conf/server.xml
ENV CATALINA_HOME=/home/exec/apache-tomcat-8.0.32

CMD /bin/bash -c cd /home/exec; /home/exec/apache-tomcat-8.0.32/bin/catalina.sh run


