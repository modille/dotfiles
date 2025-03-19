#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

cp pre-push.sh .git/hooks/pre-push

chmod +x .git/hooks/pre-push
