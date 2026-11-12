#!/bin/sh
# TOS wrapper: start JupyterLab from the Anaconda image as uid 1000, with a
# random access token persisted in the data folder.
set -u
set -e
mkdir -p /data
TOKEN_FILE=/data/.jupyter-token
if [ ! -s "$TOKEN_FILE" ]; then
  head -c 18 /dev/urandom | base64 | tr -d '\n' > "$TOKEN_FILE"
fi
TOKEN=$(cat "$TOKEN_FILE")
exec jupyter lab --ip=0.0.0.0 --port=8888 --no-browser \
  --ServerApp.token="$TOKEN" --ServerApp.password="" \
  --ServerApp.root_dir=/data
