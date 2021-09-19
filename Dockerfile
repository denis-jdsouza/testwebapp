# Temp container to build jar using gradle
FROM gradle:5.4.1-jdk8-alpine AS builder
LABEL maintainer="Denis DSouza"
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon

# Actual container
FROM centos:7
RUN yum -y update
RUN yum -y remove java
RUN yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk/
RUN mkdir /app
COPY --from=builder /home/gradle/src/build/libs/*.jar /app/spring-boot-testwebapp.jar
EXPOSE 8080
CMD ["java", "-jar", "/app/spring-boot-testwebapp.jar"]