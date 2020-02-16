#!/usr/bin/env bash

# Installs a common base set of applications to allow other images to be quickly spun up
cd ..
./install.sh docker.pp dotnetutilities.pp utilities.pp octopus.pp octopuscli.pp octopusicon.pp desktop.pp

# Wait for Octopus
./scripts/linux/wait-octopus.sh