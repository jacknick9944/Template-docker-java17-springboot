FROM khipu/openjdk17-alpine
LABEL authors="jackd"

COPY . /app
WORKDIR /app
RUN ./mvnw package
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/target/demo-0.0.1-SNAPSHOT.jar"]
