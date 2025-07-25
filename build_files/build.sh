#!/usr/bin/env bash

set -ouex pipefail

# Hyprland
/ctx/build_files/packages/00-hyprland.sh

# Common Packages
/ctx/build_files/packages/common/00-common.sh
/ctx/build_files/packages/common/10-theme.sh

pip install --prefix=/usr yafti

systemctl enable podman.socket

ostree container commit
