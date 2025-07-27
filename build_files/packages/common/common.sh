#! /usr/bin/env bash

set -ouex pipefail

# Read Packages to install
readarray -t COMMON_PKGS < <(jq -r ".common.include | sort | unique[]" /ctx/build_files/packages/packages.json)

readarray -t FONT_PKGS < <(jq -r ".fonts.include | sort | unique[]" /ctx/build_files/packages/packages.json)

readarray -t ICON_PKGS < <(jq -r ".icons.include | sort | unique[]" /ctx/build_files/packages/packages.json)

readarray -t MEDIA_PKGS < <(jq -r ".media.include | sort | unique[]" /ctx/build_files/packages/packages.json)

readarray -t THEME_PKGS < <(jq -r ".themes.include | sort | unique[]" /ctx/build_files/packages/packages.json)

readarray -t VIRT_PKGS < <(jq -r ".virt.include | sort | unique[]" /ctx/build_files/packages/packages.json)

# Enable necessary COPR repositories
dnf5 -y copr enable che/nerd-fonts

# Install packages
dnf5 -y install  --skip-unavailable "${COMMON_PKGS[@]} ${FONT_PKGS[@]} ${ICON_PKGS[@]} ${MEDIA_PKGS[@]} ${THEME_PKGS[@]}" 

# Read packages to remove
readarray -t COMMON_PKGS < <(jq -r ".common.exclude | sort | unique[]" /ctx/build_files/packages/packages.json)

# Remove packages
dnf5 -y remove "${COMMON_PKGS[@]}"

# Disable any COPR repositories
dnf5 -y copr disable che/nerd-fonts
