#! /usr/bin/env bash

set -ouex pipefail

readarray -t HYPRLAND_PKGS < <(jq -r ".hyprland.include | sort | unique[]" packages.json)

readarray -t WAYLAND_PKGS < <(jq -r ".wayland.include | sort | unique[]" packages.json)

dnf5 -y copr enable solopasha/hyprland

dnf5 -y install "${HYPRLAND_PKGS[@]}" "${WAYLAND_PKGS[@]}"

dnf5 -y copr disable solopasha/hyprland
