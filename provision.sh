#!/usr/bin/env bash

# Directories:
# /usr/local/concourse/bin: executables of concourse-ci
# /etc/concourse/keys: generated keys for running web and worker
# /var/lib/concourse: concourse data directory

VERSION=0.8.3

fetch_concourse_cli() {
    local -r base_dl_url="https://github.com/concourse/concourse/releases/download/v${VERSION}"
    download_dir=$(mktemp -d)
    pushd "$download_dir"
    curl -C - -LO "${base_dl_url}/concourse-${VERSION}-linux-amd64.tgz"
    tar xvf "concourse-${VERSION}-linux-amd64.tgz"
    tar xvf concourse/fly-assets/fly-linux-amd64.tgz
    rm -r concourse/fly-assets/
    mv fly /usr/local/bin/
    mv concourse/ /usr/local/
    popd
    rm -r "$download_dir"
}

if [ ! -e "/usr/local/concourse/bin/" ]; then
    printf "Fetch concourse CLI\n" >&2
    fetch_concourse_cli
fi

export PATH="/usr/local/concourse/cli:$PATH"

keys_dir="/etc/concourse/keys"
[ -e "$keys_dir" ] || mkdir -p "$keys_dir"
printf "Set up keys under working directory %s" "$keys_dir" >&2
[ -e "${keys_dir}/session_signing_key" ] || concourse generate-key -t rsa -f "${keys_dir}/session_signing_key"
[ -e "${keys_dir}/tsa_host_key" ] || concourse generate-key -t ssh -f "${keys_dir}/tsa_host_key"
[ -e "${keys_dir}/worker_key" ] || concourse generate-key -t ssh -f "${keys_dir}/worker_key"

cat "${keys_dir}/worker_key.pub" >"${keys_dir}/authorized_worker_keys"

[ -e /var/lib/concourse/ ] || mkdir -p /var/lib/concourse
