
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /build

COPY ./pom.xml ./
COPY ./src ./src

RUN mvn clean package -DskipTests


# Stage 2: Run the application
FROM eclipse-temurin:21-jre

WORKDIR /app

# Copy the built jar from the build stage
COPY --from=build /build/target/*.jar app.jar

EXPOSE 80

CMD ["java", "-jar", "app.jar"]
