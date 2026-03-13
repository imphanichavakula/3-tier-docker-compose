# Stage 1: Build
FROM openjdk:17 AS build
WORKDIR /app

# Install Maven
RUN apk add --no-cache maven

# Copy project files
COPY pom.xml .
COPY src ./src

# Build the app
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM openjdk:17.0.8-jdk-alpine

WORKDIR /app

# Copy jar from build stage
COPY --from=build /app/target/*.jar app.jar

# Expose port
EXPOSE 8080

# Run app
CMD ["java", "-jar", "app.jar"]
