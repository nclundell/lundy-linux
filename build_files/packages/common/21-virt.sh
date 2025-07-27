
#! /usr/bin/env bash

set -ouex pipefail

readarray -t VIRT_PKGS < <(jq -r ".virt.include | sort | unique[]" /ctx/build_files/packages/packages.json)

dnf5 -y install --skip-unavailable "${VIRT_PKGS[@]}"
