FROM ubuntu:latest AS build
RUN apt-get update
RUN apt-get install openjdk-17 -y
RUN apt-get install maven -y
COPY . .
RUN mvn clean package
RUN java -jar server/target/server.jar

FROM openjdk:17-jdk-slim
EXPOSE 8080
COPY --from=build /server/target/server.jar app.jar

ENTRYPOINT ["java","-jar","app.jar"]