#!/usr/bin/env bash

podman run --name concourse-pg-db \
-e POSTGRES_DB=concourse \
-e POSTGRES_USER=concourse \
-e POSTGRES_PASSWORD=concourse_pass \
-p 5432:5432 \
--health-interval 10s \
--health-timeout 5s \
--health-retries 5 \
--health-cmd "isready -U concourse" \
-v concourse-data:/var/lib/postgresql/data \
postgres:15

# vim: ts=2 sw=2 et
