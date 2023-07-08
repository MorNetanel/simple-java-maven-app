FROM maven:latest AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=builder /app/target/my-app-*.jar /app/my-app.jar
CMD ["java", "-jar", "/app/my-app.jar"]

