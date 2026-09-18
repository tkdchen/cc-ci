#!/usr/bin/env bash

export CONCOURSE_TSA_HOST="127.0.0.1:2222"
export CONCOURSE_WORK_DIR="/var/lib/concourse"
export CONCOURSE_TSA_PUBLIC_KEY="/etc/concourse/keys/tsa_host_key.pub"
export CONCOURSE_TSA_WORKER_PRIVATE_KEY="/etc/concourse/keys/worker_key"

export PATH="/usr/local/concourse/bin:$PATH"

concourse worker
