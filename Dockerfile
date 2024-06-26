# Stage 1: Build the application
FROM maven:3.6.3-jdk-8-slim AS build
WORKDIR /app
COPY . /app
RUN mvn clean package -DskipTests

# Stage 2: Create the runnable image
FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/lavagna-jetty-console.war /app/lavagna-jetty-console.war
COPY entrypoint.sh /app/entrypoint.sh
RUN apk add --no-cache bash netcat-openbsd
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
