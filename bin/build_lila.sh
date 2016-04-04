#! /bin/bash

RUN="docker-compose run web"
$RUN ./bin/build-deps.sh
$RUN sbt compile
$RUN ./ui/build
$RUN ./bin/install-stockfish
$RUN ./bin/gen/geoip
$RUN ./bin/svg-optimize
$RUN cp ./docker/lila/application.conf conf/
