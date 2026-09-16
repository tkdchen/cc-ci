#!/usr/bin/env bash

export CONCOURSE_TSA_HOST="127.0.0.1:2222"
export CONCOURSE_WORK_DIR="/home/cqi/code/cc-ci/workspace"
export CONCOURSE_TSA_PUBLIC_KEY="/home/cqi/code/cc-ci/keys/tsa_host_key.pub"
export CONCOURSE_TSA_WORKER_PRIVATE_KEY="/home/cqi/code/cc-ci/keys/worker_key"

/home/cqi/concourse/bin/concourse worker
