#!/bin/bash -e

# Java Jenkins K8s Docker Feed

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

export CUCUMBER_TAGS="(not @browserspecific or @chrome) and (not @destinationspecific or @microk8s) and (not @repositoryspecific or @localdockerrepo) and (not @applicationspecific or @java) and (not @sourcespecific or @git)"
export CUCUMBER_PLUGIN=pretty

export GIT_URL=https://github.com/OctopusSamples/RandomQuotes-Java.git
# From the CI server point of view, the registry is on localhost
export DOCKER_IMAGE=localhost:32000/randomquotesjava
# From Octopus' point of view, the registry has the hostname "registry"
export OCTOPUS_DOCKER_IMAGE=randomquotesjava
export CONFIG_FILE="spring:\\n  profiles:\\n    active: \\\"#{Octopus.Environment.Name}\\\"\\n  h2:\\n    console:\\n      enabled: true\\n  jpa:\\n    database-platform: org.hibernate.dialect.H2Dialect\\n  datasource:\\n    url: jdbc:h2:mem:testdb\\n    dbcp2:\\n      driver-class-name: org.h2.Driver\\n  flyway:\\n    locations: classpath:db/migration/{vendor}\\nserver:\\n  port : \\\"80\\\""
export CONFIG_FILE_MOUNT_PATH="/app/docker-application.yml"
export CONFIG_FILE_NAME="docker-application.yml"
export CREATE_RELEASE_SHELL_LOCATOR="(//div[@class='CodeMirror'])[1]"
export DOCKER_PORT=80
export K8S_DEV_NODEPORT=30000
export K8S_TEST_NODEPORT=30001
export K8S_PROD_NODEPORT=30002

cd ..

# Install Puppet
./install.sh \
  systemtimeout.pp \
  jenkins.pp \
  update.pp \
  microk8s.pp \
  vagrantmicrok8s.pp \
  jenkinsdocker.pp \
  sleep.pp \
  jenkinsfinalize.pp \
  jenkinsicon.pp \
  microk8sicon.pp \
  passwords.pp

# Wait for Octopus
./scripts/linux/wait-octopus.sh

# Create Api Key
./scripts/linux/create-apikey.sh

# Create Jenkins project
./scripts/linux/create-javak8s-jenkinsproject.sh

# Create worker
./scripts/linux/create-worker.sh

# Create environments
./scripts/linux/create-environments.sh

# Create certificates
./scripts/linux/create-certificates.sh

# Create k8s account
./scripts/linux/create-microk8saccount.sh

# Create Target
./scripts/linux/create-k8starget-vagrant.sh

# Create docker feed
./scripts/linux/create-dockerfeed.sh

# Create project
./scripts/linux/create-k8sproject.sh

# Restart microk8s
./install.sh restartmicrok8s.pp

# Create release
./scripts/linux/create-jenkinscreatereleaseplugin.sh

# Restart microk8s
./install.sh restartmicrok8s.pp

# Create Lifecycle
./scripts/linux/create-lifecycle.sh

# Restart microk8s
./install.sh restartmicrok8s.pp

# Add Manual Intervention
./scripts/linux/add-manualintervention.sh

# Add Users and Teams
./scripts/linux/add-usersandteams.sh

# Open the test app
./scripts/linux/open-microk8s-devwebapp.sh
./scripts/linux/open-microk8s-testwebapp.sh

# Add desktop shortcuts
sudo -Hu vagrant DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus dconf write /org/gnome/shell/favorite-apps \
  "['Passwords.desktop', 'Guides.desktop', 'Octopus.desktop', 'Jenkins.desktop', 'Random Quotes Dev.desktop', 'Random Quotes Test.desktop', 'gnome-terminal.desktop']"

# Configure autoheal to allow the Octopus docker container to restart in the client VM.
# Do this last because it looked like this feature was restarting the container during configuration steps above.
./install.sh autoheal.pp

exit 0