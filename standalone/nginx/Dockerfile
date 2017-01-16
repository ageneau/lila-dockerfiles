FROM debian:8.3

MAINTAINER Sylvain Ageneau <ageneau@gmail.com>

USER root
RUN apt-get update -qq && apt-get -y install nginx

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN mkdir /etc/nginx/ssl
ADD lichess /etc/nginx/sites-available/default

EXPOSE 80

CMD ["nginx"]
