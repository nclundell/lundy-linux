#!/usr/bin/env bash

set -ouex pipefail

# Hyprland
/ctx/build_files/packages/hyprland.sh

# Common Packages
/ctx/build_files/packages/common/10-common.sh
# /ctx/build_files/packages/common/11-ublue.sh

/ctx/build_files/packages/common/30-fonts.sh
/ctx/build_files/packages/common/31-icons.sh
/ctx/build_files/packages/common/32-themes.sh

# flatpak remote-add --system --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# flatpak remote-add --user   --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

#systemctl disable flatpak-add-fedora-repos.service

systemctl enable podman.socket

ostree container commit
