# Stage 1: Build the application using Maven
FROM maven:3.9.6-eclipse-temurin-11 AS build

# Set working directory
WORKDIR /app

# Copy the project files
COPY . .

# Build the project, skipping tests (tests run in CI pipeline)
RUN mvn clean package -DskipTests

# Stage 2: Deploy to Tomcat
FROM tomcat:9.0-jdk11

# Set JVM memory limit for Render.com free tier (512MB RAM)
ENV JAVA_OPTS="-Xmx256m"

# Remove the default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file from the build stage and rename to ROOT.war
COPY --from=build /app/target/student-grade-calculator-1.0.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
