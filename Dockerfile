# Stage 1: Build the application (uses JDK)
FROM openjdk:17-jdk-alpine as build
WORKDIR /app
# Copy your application source code
COPY . /app

# Use your build tool (e.g., Maven, Gradle) to build


# Stage 2: Create the final image (uses JRE)
#FROM eclipse-temurin:17-jre-alpine

# Copy only the final artifact (JAR file)
COPY workspace/wordpipe/target/*.jar .

# Expose the port your application runs on
EXPOSE 8080

# Specify the command to run the application
CMD ["java", "-jar", "wordsmith.jar"]
