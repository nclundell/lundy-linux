#!/usr/bin/env bash

set -ouex pipefail

# Hyprland
/ctx/build_files/packages/hyprland.sh

# Common Packages
/ctx/build_files/packages/common/common.sh
/ctx/build_files/packages/common/ublue.sh

flatpak remote-add --system --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --user   --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

systemctl disable flatpak-add-fedora-repos.service

systemctl enable podman.socket

ostree container commit
