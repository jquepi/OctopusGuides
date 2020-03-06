#!/bin/bash -e

# Java Jenkins Tomcat Builtin Feed

# This script is intentded to be run as a Vagrant previder to populate a Ubuntu image with a similar configuration
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

export CUCUMBER_TAGS="(not @browserspecific or @chrome) and (not @destinationspecific or @microk8s) and (not @repositoryspecific or @localdockerrepo) and (not @applicationspecific or @aspnetcore) and (not @sourcespecific or @git)"
export CUCUMBER_PLUGIN=pretty

export GIT_URL=https://github.com/OctopusSamples/RandomQuotes.git
# From the CI server ponit of view, the registry is on localhost
export DOCKER_IMAGE=localhost:5000/randomquotes
# From Octopus' point of view, the registry has the hostname "registry"
export OCTOPUS_DOCKER_IMAGE=randomquotes
export CONFIG_FILE="{\\n  \\\"Logging\\\": {\\n    \\\"IncludeScopes\\\": false,\\n    \\\"LogLevel\\\": {\\n      \\\"Default\\\": \\\"Warning\\\"\\n    }\\n  },\\n  \\\"AppSettings\\\": {\\n    \\\"AppVersion\\\": \\\"0.0.0\\\",\\n    \\\"EnvironmentName\\\": \\\"#{Octopus.Environment.Name}\\\"\\n  }\\n}"
export CONFIG_FILE_MOUNT_PATH="/app/appsettings.json"
export CONFIG_FILE_NAME="appsettings.json"
export DOCKER_PORT=80

cd ..

# Install Puppet
./install.sh \
  bamboo.pp \
  update.pp \
  dockerregistry.pp \
  microk8s.pp \
  vagrantmicrok8s.pp \
  dotnetutilities.pp \
  bamboofinalize.pp \
  microk8sicon.pp \
  passwords.pp \
  vagrantuser.pp

# Wait for Octopus
./scripts/linux/wait-octopus.sh

# Create Api Key
./scripts/linux/create-apikey.sh

# Create Jenkins project
./scripts/linux/create-bambooproject.sh

# Create worker
./scripts/linux/create-worker.sh

# Wait for Octopus
./scripts/linux/wait-octopus.sh

# Create environments
./scripts/linux/create-environments.sh

# Wait for Octopus
./scripts/linux/wait-octopus.sh

# Create certificates
./scripts/linux/create-certificates.sh

# Wait for Octopus
./scripts/linux/wait-octopus.sh

# Create k8s account
./scripts/linux/create-microk8saccount.sh

# Wait for Octopus
./scripts/linux/wait-octopus.sh

# Create Target
./scripts/linux/create-k8starget-vagrant.sh

# Wait for Octopus
./scripts/linux/wait-octopus.sh

# Create docker feed
./scripts/linux/create-dockerfeed.sh

# Wait for Octopus
./scripts/linux/wait-octopus.sh

# Create project
./scripts/linux/create-k8sproject.sh

# Create release
./scripts/linux/create-bamboocreaterelease.sh

# Wait for Octopus
./scripts/linux/wait-octopus.sh

# Create Lifecycle
./scripts/linux/create-lifecycle.sh

# Wait for Octopus
./scripts/linux/wait-octopus.sh

# Add Manual Intervention
./scripts/linux/add-manualintervention.sh

# Wait for Octopus
./scripts/linux/wait-octopus.sh

# Add Users and Teams
./scripts/linux/add-usersandteams.sh

# Add desktop shortcuts
sudo -Hu vagrant DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus dconf write /org/gnome/shell/favorite-apps \
  "['Passwords.desktop', 'Guides.desktop', 'Octopus.desktop', 'Random Quotes Dev.desktop', 'Random Quotes Test.desktop', 'gnome-terminal.desktop']"

exit 0