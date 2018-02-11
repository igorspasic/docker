FROM openjdk:8

COPY . /usr/src
WORKDIR /usr/src

RUN ./gradlew clean

CMD ["./gradlew", "run"]
