#! /usr/bin/env bash

set -ouex pipefail

readarray -t FONT_PKGS < <(jq -r ".fonts.include | sort | unique[]" /ctx/build_files/packages/packages.json)

dnf5 -y copr enable che/nerd-fonts

dnf5 -y install --skip-unavailable "${FONT_PKGS[@]}"

dnf5 -y copr disable che/nerd-fonts
