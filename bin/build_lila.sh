#! /bin/bash

info() {
    echo "INFO: $*"
}

clone_sources() {
    test -d lila || mkdir lila
    if ! test -d lila/lila; then
        git clone --recursive https://github.com/ornicar/lila.git lila/lila
    else
        info 'Not cloning lila in lila/lila as it already exists'
    fi
    if ! test -d lila/explorer; then
        git clone --recursive https://github.com/niklasf/lila-openingexplorer.git lila/explorer
    else
        info 'Not cloning explorer in lila/explorer as it already exists'
    fi
}

build_lila() {
    RUN="docker-compose run lila"
    $RUN ./bin/build-deps.sh
    $RUN sbt compile
    $RUN ./ui/build
    $RUN ./bin/install-stockfish
    $RUN ./bin/gen/geoip
    $RUN ./bin/svg-optimize
    cp lila-server/application.conf lila/lila/conf/
}

build_explorer() {
    RUN="docker-compose run explorer"
    $RUN ./bin/build-deps.sh
    $RUN sbt compile
    cp lila/explorer/conf/application.conf.example lila/explorer/conf/application.conf
}

main() {
    clone_sources
    build_lila
    build_explorer

    info 'Lila is all set up! Add this entry to your hosts file on your'
    info 'host machine'
    info
    info '    127.0.0.1 l.org en.l.org de.l.org le.l.org fr.l.org es.l.org l1.org socket.en.l.org socket.le.l.org socket.fr.l.org ru.l.org el.l.org hu.l.org socket.hu.l.org'
    info
    info 'Then run "docker-compose run lila" and visit  http://en.l.org on your host machine.'
}

# main
clone_sources
