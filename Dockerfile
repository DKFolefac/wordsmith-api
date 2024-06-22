
FROM maven:3.8-jdk-alpine as build
WORKDIR /app
# Copy your application pom file
COPY pom.xml .

# Use your build tool (e.g., Maven, Gradle) to build
RUN mvn verify -DskipTests --fail-never
COPY src ./src
RUN mvn verify


# Stage 2: Create the final image (uses JRE)
# Copy only the final artifact (JAR file)
FROM  openkdk:17-jre-alpine
WORKDIR /app
COPY --from=build /app/target .

# Expose the port your application runs on
EXPOSE 8080

# Specify the command to run the application

ENTRYPOINT ["java", "-jar", "/app/target/words.jar"]
