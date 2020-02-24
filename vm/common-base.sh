#!/bin/bash -e

# Installs a common base set of applications to allow other images to be quickly spun up
cd ..
./install.sh \
  update.pp \
  docker.pp \
  dotnetutilities.pp \
  utilities.pp \
  octopus.pp \
  octopuscli.pp \
  octopusicon.pp \
  bookicon.pp \
  desktop.pp \
  networkwait.pp

# Wait for Octopus
./scripts/linux/wait-octopus.sh

exit 0