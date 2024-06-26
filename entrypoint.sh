#!/bin/bash

# Wait for MySQL to be ready
while ! nc -z db 3306; do
  echo "Waiting for the MySQL server to be ready..."
  sleep 2
done

java -Ddatasource.dialect=MYSQL \
     -Ddatasource.url=${DATASOURCE_URL} \
     -Ddatasource.username=${DATASOURCE_USERNAME} \
     -Ddatasource.password=${DATASOURCE_PASSWORD} \
     -Dspring.profile.active=${SPRING_PROFILE_ACTIVE} \
     -jar /app/lavagna-jetty-console.war
