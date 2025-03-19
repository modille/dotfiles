#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if ! command -v gitleaks &>/dev/null; then
  echo "Install gitleaks"
  echo "https://github.com/gitleaks/gitleaks?tab=readme-ov-file#installing"
  exit 1
fi

gitleaks git --verbose
