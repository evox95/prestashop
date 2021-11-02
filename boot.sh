#!/bin/bash

ROOT_DIR=$(pwd);
echo "Work dir: ${ROOT_DIR}";

trap project_stop INT

project_info() {
  echo
  echo
  echo ">> ${1}"
  echo
}

project_stop() {
  project_info "STOP PROJECT..."
  cd "${ROOT_DIR}" || exit;
  # stop docker containers
  docker_compose_adapter down;
  exit
}

project_compose() {
  if [[ ! -d "${ROOT_DIR}/shop/admin-dev" ]]; then
    project_info "BUILD PROJECT..."
    cd "${ROOT_DIR}" || exit;
    ./compose.sh
  fi
}

project_start() {
  project_compose;

  project_info "START PROJECT..."
  SLEEP_TIME=5
  if [[ ! -d "${ROOT_DIR}/database" ]]; then
    SLEEP_TIME=30
  fi
  # recreate docker containers
  docker_compose_adapter down
  docker_compose_adapter up -d
  sleep $SLEEP_TIME

  project_info "RUN MIGRATIONS..."
  curl -s http://127.0.0.1/migrations/run.php >/dev/null 2>&1

  project_info "PROJECT IS UP..."
  echo "Enter CTRL+C to stop"
  while true
  do
     sleep 3
  done

  project_stop
}

docker_compose_adapter() {
 mutagen compose -f "${ROOT_DIR}/docker-mutagen.yml" "${@}" 2>/dev/null || docker compose "${@}" || docker-compose "${@}"
}

project_start
