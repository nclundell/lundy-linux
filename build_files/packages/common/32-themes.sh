#! /usr/bin/env bash

set -ouex pipefail

readarray -t THEME_PKGS < <(jq -r ".themes.include | sort | unique[]" /ctx/build_files/packages/packages.json)

dnf5 -y install --skip-unavailable "${THEME_PKGS[@]}"
