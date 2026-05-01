# Use Tomcat 9 with JDK 11 as the base image
FROM tomcat:9.0-jdk11

# Set JVM memory limit for Render.com free tier (512MB RAM)
ENV JAVA_OPTS="-Xmx256m"

# Remove the default Tomcat webapps to keep things clean
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built WAR file from the Maven target folder
# and rename it to ROOT.war so it runs at the root URL (/)
COPY target/student-grade-calculator-1.0.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080 (Tomcat's default port)
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
