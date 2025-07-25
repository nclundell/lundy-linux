#! /usr/bin/env bash

set -ouex pipefail

readarray -t COMMON_PKGS < <(jq -r ".common.include | sort | unique[]" /ctx/build_files/packages/packages.json)

dnf5 -y install "${COMMON_PKGS[@]}"
