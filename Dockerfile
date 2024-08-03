
FROM maven:3.9-eclipse-temurin-17-alpine as build
WORKDIR /app
# Copy your application pom file
COPY pom.xml .

# Use your build tool (e.g., Maven, Gradle) to build
#RUN mvn verify -DskipTests --fail-never
RUN mvn dependency:resolve -q
COPY src ./src
RUN mvn clean package


# Stage 2: Create the final image (uses JRE)
# Copy he final artifact (JAR file)
FROM  eclipse-temurin:17-alpine
#new line
COPY --from=build /app/target/classes /app/classes
COPY --from=build /app/target/dependency /app/dependency
COPY --from=build /app/target/*.jar words.jar

# Expose the port your application runs on
EXPOSE 8080
# Specify the command to run the application

ENTRYPOINT ["java", "-jar", "words.jar"]


