FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy the JAR file from local build output (relative to Docker build context)
COPY target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]

