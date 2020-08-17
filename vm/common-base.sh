#!/bin/bash -e

# Installs a common base set of applications to allow other images to be quickly spun up
cd ..
./install.sh \
  update.pp \
  docker.pp \
  dotnetutilities.pp \
  utilities.pp \
  mssql.pp \
  mssql-cleanstart.pp octopus.pp \
  octopuscli.pp \
  octopusicon.pp \
  bookicon.pp \
  desktop.pp \
  powershell.pp \
  networkwait.pp

# Wait for Octopus
./scripts/linux/wait-octopus.sh

# Disable lock screens and sleeping
sudo -Hu vagrant dbus-launch dconf write /org/gnome/desktop/screensaver/lock-enabled false
sudo -Hu vagrant dbus-launch dconf write /org/gnome/desktop/session/idle-delay 'uint32 0'
sudo -Hu vagrant dbus-launch dconf write /org/gnome/settings-daemon/plugins/power/sleep-display-ac 0
sudo -Hu vagrant dbus-launch dconf write /org/gnome/settings-daemon/plugins/power/sleep-display-battery 0

exit 0