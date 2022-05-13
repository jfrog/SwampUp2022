# install maven and JDK
FROM maven:3.6.3-jdk-8 AS build-env
WORKDIR /app

COPY pom.xml ./

# download dependency
RUN mvn dependency:go-offline

COPY . ./
RUN mvn validate compile test package

FROM openjdk:8-jre-alpine