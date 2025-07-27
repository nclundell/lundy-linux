#! /usr/bin/env bash

set -ouex pipefail

readarray -t UBLUE_PKGS < <(jq -r ".ublue.include | sort | unique[]" /ctx/build_files/packages/packages.json)

dnf5 -y copr enable ublue-os/staging
dnf5 -y copr enable ublue-os/packages

dnf5 -y install  --skip-unavailable "${UBLUE_PKGS[@]}"

dnf5 -y copr disable ublue-os/staging
dnf5 -y copr disable ublue-os/packages

# Prevent Distrobox containers from being updated via the background service
if [[ "$(rpm -E %fedora)" -eq "42" ]]; then
    sed -i 's|uupd|& --disable-module-distrobox|' /usr/lib/systemd/system/uupd.service
fi

# Setup Systemd
systemctl enable rpm-ostree-countme.service
systemctl enable brew-setup.service
systemctl enable brew-upgrade.timer
systemctl enable brew-update.timer
systemctl enable ublue-fix-hostname.service
systemctl enable check-sb-key.service
systemctl enable input-remapper.service
systemctl --global enable podman-auto-update.timer

# Updater
if systemctl cat -- uupd.timer &> /dev/null; then
    systemctl enable uupd.timer
else
    systemctl enable rpm-ostreed-automatic.timer
    systemctl enable flatpak-system-update.timer
    systemctl --global enable flatpak-user-update.timer
fi
