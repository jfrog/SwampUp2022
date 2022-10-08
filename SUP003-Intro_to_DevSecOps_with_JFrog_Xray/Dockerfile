FROM eclipse-temurin:11-jdk-alpine


WORKDIR /usr/local

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh && \
    apk add --no-cache curl tar bash procps && \
    apk add --no-cache ca-certificates && \
    apk add --no-cache --update npm

# Downloading and installing Maven
ARG MAVEN_VERSION=3.8.5
ARG USER_HOME_DIR="/root"
ARG SHA=89ab8ece99292476447ef6a6800d9842bbb60787b9b8a45c103aa61d2f205a971d8c3ddfb8b03e514455b4173602bd015e82958c0b3ddc1728a57126f773c743
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN update-ca-certificates -v

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && echo "Downlaoding maven" \
  && curl -k -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha512sum -c - \
  && echo "Unziping maven" \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  \
  && echo "Cleaning and setting links" \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

# BEGIN install jfrog CLI
RUN curl -fL https://install-cli.jfrog.io | sh
# END install jfrog CLI

# add sources
ADD lab-3/project-examples project-examples
# add scripts
ADD scripts-delete/setupCLI.sh setupCLI.sh
ADD scripts-delete scripts
ADD docs docs
ADD README.md README.md
ADD repository-delete /root/.m2/repository

# set permissions
RUN chmod +x setupCLI.sh

CMD ["/bin/bash"]
