#!/usr/bin/env bash
#
# SPDX-License-Identifier: GPL-3.0-or-later

set -e -u

# NVIDIA modulok betöltése automatikusan
echo -e "nvidia\nnvidia_modeset\nnvidia_uvm\nnvidia_drm" > /etc/modules-load.d/nvidia.conf

# Nouveau tiltása, DRM mód engedélyezése
cat > /etc/modprobe.d/nvidia.conf <<EOF
blacklist nouveau
options nvidia_drm modeset=1
EOF

# Xorg konfiguráció
if command -v nvidia-xconfig &>/dev/null; then
    nvidia-xconfig
fi
# Warning: customize_airootfs.sh is deprecated! Support for it will be removed in a future archiso version.

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist

useradd -m -p "" -g users -G "adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" -s /bin/bash liveuser
chown -R liveuser:users /home/liveuser

