ARG REGISTRY=yann-sbx.dev.gcp.devopsacc.team
ARG DOCKER_REPO=urs-docker

FROM $REGISTRY/$DOCKER_REPO/groovy:jre16

# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG REGISTRY

# dummy 
RUN mkdir -p /home/groovy/webapp/
COPY multi-module-application.jar /home/groovy/webapp/multi-module-application.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/home/groovy/webapp/multi-module-application.jar"]