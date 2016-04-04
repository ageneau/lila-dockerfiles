FROM ageneau/scala-base:latest

MAINTAINER Sylvain Ageneau <ageneau@gmail.com>

RUN apt-get install -y --no-install-recommends libkyotocabinet-dev kyotocabinet-utils
RUN apt-get clean && apt-get autoclean

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
WORKDIR /project
RUN curl http://fallabs.com/kyotocabinet/javapkg/kyotocabinet-java-1.24.tar.gz | tar xvz
WORKDIR /project/kyotocabinet-java-1.24
RUN ./configure
RUN make all install
RUN rm -rf /project/kyotocabinet-java-1.24

WORKDIR /lila/explorer

CMD ["sbt", "run", "-Djava.library.path=/usr/local/lib/"]
EXPOSE 9000
