FROM khipu/openjdk17-alpine
LABEL authors="jackd"

RUN apk add --no-cache curl tar bash

ENV PROYECT_NAME=demo
ENV MAVEN_VERSION=3.8.3
ENV MAVEN_HOME=/opt/maven
ENV PATH="${MAVEN_HOME}/bin:${PATH}"

RUN curl -fsSL https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz | tar xzf - -C /opt \
    && ln -s /opt/apache-maven-${MAVEN_VERSION} ${MAVEN_HOME} \
    && rm -rf /tmp/*

COPY . /app
WORKDIR /app
RUN mvn package
COPY --from=build /app/target/${PROYECT_NAME}-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]