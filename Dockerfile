FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY  src ./src
RUN mvn package -DskipTests

FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=build /app/target/*.jar ./usermanagement-application-image.jar

EXPOSE 8081

CMD ["java", "-jar" , "usermanagement-application-image.jar"]
