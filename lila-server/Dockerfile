FROM ageneau/scala-base:latest

MAINTAINER Sylvain Ageneau <ageneau@gmail.com>

WORKDIR /lila/lila

ENV JAVA_OPTS="-Xms64M -Xmx3072M -Xss4M -XX:ReservedCodeCacheSize=64m -XX:+CMSClassUnloadingEnabled -XX:+UseConcMarkSweepGC"

RUN apt-get update -qq && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:lila' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22 9663
CMD ["/usr/sbin/sshd", "-D"]
