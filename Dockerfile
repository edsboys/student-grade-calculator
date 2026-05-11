# Stage 1: Build the application using Maven
FROM maven:3.9.6-eclipse-temurin-11 AS build

WORKDIR /app

COPY . .

RUN mvn clean package -DskipTests

# Stage 2: Deploy to Tomcat
FROM tomcat:9.0-jdk11

ENV JAVA_OPTS="-Xmx256m"

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /app/target/grade-calculator.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
