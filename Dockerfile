# Stage 1: Build the application with Maven
FROM maven:3.8.4-openjdk-11 AS builder

WORKDIR /app

# Copy the Maven project files
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package

# Stage 2: Create a lightweight image with the application artifact
FROM openjdk:11-jre-slim

WORKDIR /app

# Copy the application artifact from the builder stage
COPY --from=builder /app/target/my-app.jar .

# Run the application
CMD ["java", "-jar", "my-app.jar"]
