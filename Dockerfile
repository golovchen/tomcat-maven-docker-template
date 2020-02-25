FROM maven:3.5.2-jdk-8-alpine AS MAVEN_TOOL_CHAIN
COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
RUN mvn package

FROM tomcat:8
COPY --from=MAVEN_TOOL_CHAIN /tmp/target/tomcat-maven-docker-template-1.0.war $CATALINA_HOME/webapps/
COPY conf/server.xml /usr/local/tomcat/conf/server.xml
EXPOSE 80
