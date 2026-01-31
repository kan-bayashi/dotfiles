#!/bin/bash

NTFY_TOPIC="claude-908117c4d34b4e3c9608e2933aaecc2f"
PROJECT_NAME=$(basename "$PWD")

curl -s -d "${PROJECT_NAME}: 入力待ちです" "ntfy.sh/${NTFY_TOPIC}" > /dev/null
