FROM cycloid/github-cli as downloader
ARG GH_TOKEN
ENV GH_TOKEN=$GH_TOKEN
WORKDIR /app
RUN gh release download --pattern "JMusicBot-0.3.9.jar" --repo jagrosh/MusicBot
RUN mv JMusicBot-0.3.9.jar JMusicBot.jar

FROM eclipse-temurin:11-jre-focal
COPY --from=downloader /app/JMusicBot.jar /app/JMusicBot.jar
WORKDIR /app
ENTRYPOINT ["java", "-Dconfig=/app/config.txt", "-Dnogui=true", "-jar", "/app/JMusicBot.jar"]
