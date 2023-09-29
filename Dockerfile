# First stage: complete build environment
FROM maven:3.8.2-jdk-17 AS build
#RUN apt-get update
#RUN apt-get install openjdk-17-jdk -y

# pom.xml and source code
COPY . .

# package jar
RUN mvn clean package -DskipTests

# Second stage: runtime environment
FROM openjdk:17-jdk-slim

# ENV PORT=8080
EXPOSE 8080

COPY --from=build /target/demo-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]