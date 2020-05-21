#!/bin/bash -e

# Java Jenkins Websphere Builtin Feed

# This script is intended to be run as a Vagrant provider to populate a Ubuntu image with a similar configuration
# as described in the guides documentation. Note that the SMTP notification step is not included so as not to
# expose the SMTP password.

export STHREE_SCREENSHOT_ENABLED=true
export SLACK_STEP_HANDLER=true
export SLACK_ON_ERROR_ONLY=false

export DISABLE_HIGHLIGHTS=true
export DISABLE_SCREENSHOTS=true
export MOVE_TO_MOUSE_CURSOR=false
export DISABLE_VIDEO=true
export SCREENSHOT_BUCKET=octopus-guides-screenshots
export STEP_PAUSE=1000

export BROWSER_TYPE=ChromeHeadlessNoImplicitWaitLambda

export CUCUMBER_TAGS="(not @browserspecific or @chrome) and (not @destinationspecific or @websphere) and (not @repositoryspecific or @octo-built-in-feed) and (not @applicationspecific or @java) and (not @sourcespecific or @git)"
export CUCUMBER_PLUGIN=pretty

export GIT_URL=https://github.com/OctopusSamples/RandomQuotes-Java.git
export DOCKER_IMAGE=octopusdeploy/randomquotesjava
export CREATE_RELEASE_SHELL_LOCATOR="(//div[@class='CodeMirror'])[2]"

cd ..

# Install Puppet
./install.sh \
  jenkins.pp \
  update.pp \
  websphere.pp \
  sleep.pp \
  jenkinsfinalize.pp \
  jenkinsicon.pp \
  websphereicon.pp \
  octopusicon.pp \
  passwords.pp

# Wait for Octopus
./scripts/linux/wait-octopus.sh

# Create Api Key
./scripts/linux/create-apikey.sh

# Create Jenkins project
./scripts/linux/create-javawar-jenkinsproject.sh

# Create environments
./scripts/linux/create-environments.sh

# Create Target
./scripts/linux/create-target.sh

# Create project
./scripts/linux/create-websphereproject.sh

# Create release
./scripts/linux/create-jenkinscreaterelease.sh

# Create Lifecycle
./scripts/linux/create-lifecycle.sh

# Add Manual Intervention
./scripts/linux/add-manualintervention.sh

# Add Users and Teams
./scripts/linux/add-usersandteams.sh

# Add desktop shortcuts
sudo -Hu vagrant DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus dconf write /org/gnome/shell/favorite-apps \
  "['Passwords.desktop', 'Guides.desktop', 'Octopus.desktop', 'Jenkins.desktop', 'Random Quotes Dev.desktop', 'Random Quotes Test.desktop', 'gnome-terminal.desktop']"

# Configure autoheal to allow the Octopus docker container to restart in the client VM.
# Do this last because it looked like this feature was restarting the container during configuration steps above.
./install.sh autoheal.pp

exit 0