#! /bin/bash

info() {
    echo "INFO: $*"
}

check_requirements() {
    command -v docker >/dev/null 2>&1 || { echo '"docker" not found"'; exit 1; }
    command -v docker-compose >/dev/null 2>&1 || { echo '"docker-compose" not found"'; exit 1; }
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

create_containers() {
    info 'Pulling the latest version of containers from dockerhub'
    docker pull ageneau/fishnet
    docker pull ageneau/scala-base
    info 'Building containers'
    docker-compose build
    info 'Done building containers'
}

build_lila() {
    info 'Building lila'
    RUN="docker-compose run lila"
    $RUN ./bin/build-deps.sh
    $RUN sbt compile
    $RUN ./ui/build
    $RUN ./bin/install-stockfish
    $RUN ./bin/gen/geoip
    $RUN ./bin/svg-optimize
    cp lila-server/application.conf lila/lila/conf/
    cp lila/lila/bin/dev.default lila/lila/bin/dev
    chmod +x lila/lila/bin/dev
    info 'Building lila done'
}

build_explorer() {
    info 'Building lila explorer'
    RUN="docker-compose run explorer"
    $RUN ./bin/build-deps.sh
    $RUN sbt compile
    cp explorer/application.conf lila/explorer/conf/application.conf
    info 'Building lila explorer done'
}

main() {
    check_requirements
    clone_sources
    create_containers
    build_lila
    build_explorer

    info 'Lila is all set up! Add this entry to your hosts file on your'
    info 'host machine'
    info
    info '    127.0.0.1 l.org socket.l.org en.l.org de.l.org le.l.org fr.l.org es.l.org l1.org socket.en.l.org socket.le.l.org socket.fr.l.org ru.l.org el.l.org hu.l.org socket.hu.l.org'
    info
    info 'docker-compose up -d'
    info 'ssh -l root -p 2222 localhost'
    info '(password is lila)'
    info 'cd /lila/lila'
    info 'sbt'
    info
    info 'when sbt finishes loading, type:'
    info 'run -Dhttp.port=9663'
    info
    info 'Open your host browser at: http://en.l.org/'
}

main
