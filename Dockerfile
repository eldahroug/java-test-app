# Stage 1: Build the application
FROM maven:3.8.6-openjdk-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Create the runtime image
FROM openjdk:11-jdk-slim
WORKDIR /app
COPY --from=build /app/target/hello-devops-1.0-SNAPSHOT.jar ./app.jar
CMD ["java", "-jar", "app.jar"]
