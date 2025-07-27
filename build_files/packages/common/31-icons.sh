#! /usr/bin/env bash

set -ouex pipefail

readarray -t ICON_PKGS < <(jq -r ".icons.include | sort | unique[]" /ctx/build_files/packages/packages.json)

dnf5 -y install --skip-unavailable "${ICON_PKGS[@]}"
