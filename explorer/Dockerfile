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
WORKDIR /project
RUN rm -rf /project/kyotocabinet-java-1.24

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:lila' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22 9000
WORKDIR /lila/explorer
CMD ["/usr/sbin/sshd", "-D"]
