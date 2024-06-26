
FROM maven:3.9.7-eclipse-temurin-17-alpine as build
WORKDIR /usr/local/app
# Copy your application pom file
COPY pom.xml .

# Use your build tool (e.g., Maven, Gradle) to build
RUN mvn verify -DskipTests --fail-never
COPY src ./src
RUN mvn clean package


# Stage 2: Create the final image (uses JRE)
# Copy only the final artifact (JAR file)
FROM  openjdk:17-alpine
WORKDIR /usr/local/app
COPY --from=build /usr/local/app/target/ .

# Expose the port your application runs on

# Specify the command to run the application

ENTRYPOINT ["java", "-jar", "usr/local/app/words.jar"]

EXPOSE 8080
