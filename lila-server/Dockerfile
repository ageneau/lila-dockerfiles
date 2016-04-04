FROM ageneau/scala-base:latest

MAINTAINER Sylvain Ageneau <ageneau@gmail.com>

WORKDIR /lila/lila

ENV JAVA_OPTS="-Xms64M -Xmx3072M -Xss4M -XX:ReservedCodeCacheSize=64m -XX:+CMSClassUnloadingEnabled -XX:+UseConcMarkSweepGC"

CMD ["sbt", "run", "-Dhttp.port=9663"]
EXPOSE 9663
