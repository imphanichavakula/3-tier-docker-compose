FROM openjdk:17-alpine AS build

WORKDIR /app

COPY . .

RUN apk update && apk add maven

RUN mvn package

FROM openjdk:17-alpine

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 9000

CMD [ "java", "-jar", "app.jar" ]

