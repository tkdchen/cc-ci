#!/usr/bin/env bash

export CONCOURSE_POSTGRES_HOST=127.0.0.1
export CONCOURSE_POSTGRES_PORT=5432
export CONCOURSE_POSTGRES_USER=concourse
export CONCOURSE_POSTGRES_PASSWORD=concourse_pass
export CONCOURSE_POSTGRES_DATABASE=concourse
export CONCOURSE_EXTERNAL_URL="http://localhost:8080"
export CONCOURSE_ADD_LOCAL_USER="admin:admin"
export CONCOURSE_MAIN_TEAM_LOCAL_USER=admin
export CONCOURSE_SESSION_SIGNING_KEY="$HOME/code/cc-ci/keys/session_signing_key"
export CONCOURSE_TSA_HOST_KEY="$HOME/code/cc-ci/keys/tsa_host_key"
export CONCOURSE_TSA_AUTHORIZED_KEYS="$HOME/code/cc-ci/keys/authorized_worker_keys"

"$HOME/concourse/bin/concourse" web
