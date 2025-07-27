#! /usr/bin/env bash

set -ouex pipefail

readarray -t MEDIA_PKGS < <(jq -r ".media.include | sort | unique[]" /ctx/build_files/packages/packages.json)

dnf5 -y install --skip-unavailable "${MEDIA_PKGS[@]}"
