#!/usr/bin/env bash

VERSION=0.8.3

fetch_concourse_cli() {
    local -r base_dl_url="https://github.com/concourse/concourse/releases/download/v${VERSION}"
    mkdir "$HOME/Downloads" || :
    pushd "$HOME/Downloads"
    curl -C - -LO "${base_dl_url}/fly-${VERSION}-linux-amd64.tgz"
    curl -C - -LO "${base_dl_url}/concourse-${VERSION}-linux-amd64.tgz"
    tar xvf "concourse-${VERSION}-linux-amd64.tgz"
    mv concourse/ "$HOME"
    tar xvf "fly-${VERSION}-linux-amd64.tgz"
    mkdir "$HOME/.local/bin" || :
    mv fly "$HOME/.local/bin/"
    popd
}

if [ ! -e "$HOME/concourse/" ]; then
    printf "Fetch concourse CLI\n" >&2
    fetch_concourse_cli
fi

export PATH="$HOME/concourse/cli:$PATH"

keys_dir="/etc/concourse/keys"
[ -e "$keys_dir" ] || sudo mkdir -p "$keys_dir"
printf "Set up keys under working directory %s" "$keys_dir" >&2
[ -e "${keys_dir}/session_signing_key" ] || concourse generate-key -t rsa -f "${keys_dir}/session_signing_key"
[ -e "${keys_dir}/tsa_host_key" ] || concourse generate-key -t ssh -f "${keys_dir}/tsa_host_key"
[ -e "${keys_dir}/worker_key" ] || concourse generate-key -t ssh -f "${keys_dir}/worker_key"
cat "${keys_dir}/worker_key.pub" >"${keys_dir}/authorized_worker_keys"

[ -e /var/lib/concourse/ ] || sudo mkdir -p /var/lib/concourse
