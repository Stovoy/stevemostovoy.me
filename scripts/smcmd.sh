#!/bin/bash -e

sm() {
    eval "_sm_$@"
}

_sm_help() {
    echo "Usage: sm <command>"
    echo "Commands:"
    echo "  help          Print this help dialog."
    echo "  reload        Reload sm."
    echo "  env           Print docker env (used by 'sm connect')."
    echo "  connect       Point docker to remote stevemostovoy.me host."
    echo "  disconnect    Point docker to local host."
    echo "  ssh           SSH into remote stevemostovoy.me host."
    echo "  shell         Open a shell into the running container."
    echo "  explore       Run a new container, skipping the entrypoint."
    echo "  build         Build the docker container."
    echo "  push          Push the docker image to the docker registry as latest."
    echo "  pull          Pull the latest images from the docker registry with docker-compose."
    echo "  attach        Launch the containers with docker-compose and attach to the output."
    echo "  all           Build and launch with attachment in one command."
    echo "  up            Launch the containers with docker-compose."
}

_sm_reload() {
    source "$BASH_SOURCE"
}

_sm_env() {
    docker-machine env stevemostovoy.me
}

_sm_connect() {
	eval $(docker-machine env stevemostovoy.me)
}

_sm_disconnect() {
    unset DOCKER_TLS_VERIFY
    unset DOCKER_HOST
    unset DOCKER_CERT_PATH
    unset DOCKER_MACHINE_NAME
    unset DOCKER_API_VERSION
}

_sm_ssh() {
    docker-machine ssh stevemostovoy.me "$@"
}

_sm_shell() {
    docker exec -it $(docker-compose ps -q stevemostovoy.me) sh
}

_sm_explore() {
    docker run -it --entrypoint sh stevemostovoy.me
}

_sm_build() {
    docker build -t stevemostovoy/stevemostovoy.me .
}

_sm_push() {
    _sm_ssh docker push stevemostovoy/stevemostovoy.me
}

_sm_pull() {
    docker-compose pull
}

_sm_attach() {
    docker-compose up
}

_sm_all() {
    _sm_build
    _sm_attach
}

_sm_up() {
    docker-compose up -d
}

export -f sm
export -f _sm_help
export -f _sm_reload
export -f _sm_connect
export -f _sm_disconnect
export -f _sm_ssh
export -f _sm_shell
export -f _sm_explore
export -f _sm_build
export -f _sm_push
export -f _sm_pull
export -f _sm_up
export -f _sm_all

echo "smcmd loaded. Use 'sm help' for info."
