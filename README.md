# Dockerfiles for building lila (https://github.com/ornicar/lila)

## PREREQUISITES ##

docker (>=1.10) and docker-compose (>= 1.6, needs to support version 2 of docker-compose config file)

## INSTALL ##

./bin/build_lila.sh

## Running ##

docker-compose up -d
ssh -l root -p 2222 localhost
(password is lila)
cd /lila/lila
sbt

when sbt finishes loading, type:
run -Dhttp.port=9663

Open your host browser at: http://en.l.org/
