ARG SERVER_NAME
ARG DOCKER_FRAMEWORK_VERSION
FROM $SERVER_NAME.jfrog.io/su-114-docker-virtual/jfrog-docker-framework:$DOCKER_FRAMEWORK_VERSION

RUN rm -rf /home/exec/apache-tomcat-8.0.32/webapps/*

ADD war/*.war /home/exec/apache-tomcat-8.0.32/webapps/ROOT.war

CMD /bin/bash -c cd /home/exec; /home/exec/apache-tomcat-8.0.32/bin/catalina.sh run
