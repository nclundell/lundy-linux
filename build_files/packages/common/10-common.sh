#! /usr/bin/env bash

set -ouex pipefail

# Read Packages to install
readarray -t COMMON_PKGS < <(jq -r ".common.include | sort | unique[]" /ctx/build_files/packages/packages.json)

# Install packages
dnf5 -y install  --skip-unavailable "${COMMON_PKGS[@]}"

# Read packages to remove
readarray -t COMMON_PKGS < <(jq -r ".common.exclude | sort | unique[]" /ctx/build_files/packages/packages.json)

# Remove packages
dnf5 -y remove "${COMMON_PKGS[@]}"
