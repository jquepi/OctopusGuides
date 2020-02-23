#!/bin/bash -e

# Java Jenkins Tomcat Builtin Feed

# This script is intentded to be run as a Vagrant previder to populate a Ubuntu image with a similar configuration
# as described in the guides documentation. Note that the SMTP notification step is not included so as not to
# expose the SMTP password.

export STHREE_SCREENSHOT_ENABLED=true
export SLACK_STEP_HANDLER=false
export SLACK_ON_ERROR_ONLY=false

export DISABLE_HIGHLIGHTS=true
export DISABLE_SCREENSHOTS=true
export MOVE_TO_MOUSE_CURSOR=false
export DISABLE_VIDEO=true
export SCREENSHOT_BUCKET=octopus-guides-screenshots
export STEP_PAUSE=1000

export BROWSER_TYPE=ChromeHeadlessNoImplicitWaitLambda

export CUCUMBER_TAGS="(not @browserspecific or @chrome) and (not @destinationspecific or @k8s) and (not @repositoryspecific or @localdockerrepo) and (not @applicationspecific or @java) and (not @sourcespecific or @git)"
export CUCUMBER_PLUGIN=pretty

export GIT_URL=https://github.com/OctopusSamples/RandomQuotes-Java.git
# From the CI server ponit of view, the registry is on localhost
export DOCKER_IMAGE=localhost:5000/randomquotesjava
# From Octopus' point of view, the registry has the hostname "registry"
export OCTOPUS_DOCKER_IMAGE=randomquotesjava
export CONFIG_FILE="spring:\\n  profiles:\\n    active: \\\"#{Octopus.Environment.Name}\\\"\\nserver:\\n  port : \\\"80\\\""
export CONFIG_FILE_MOUNT_PATH="/app/docker-application.yml"
export CONFIG_FILE_NAME="docker-application.yml"
export CREATE_RELEASE_SHELL_LOCATOR="(//div[@class='CodeMirror'])[1]"
export DOCKER_PORT=80

cd ..

# Install Puppet
./install.sh jenkins.pp update.pp dockerregistry.pp minikube.pp jenkinsdocker.pp jenkinsfinalize.pp jenkinsicon.pp passwords.pp vagrantuser.pp

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

# Create Target
./scripts/linux/create-k8starget-vagrant.sh

# Create docker feed
./scripts/linux/create-dockerfeed.sh

# Create project
./scripts/linux/create-k8sproject.sh

# Create release
./scripts/linux/create-jenkinscreaterelease.sh

# Create Lifecycle
./scripts/linux/create-lifecycle.sh

# Add Manual Intervention
./scripts/linux/add-manualintervention.sh

# Add Users and Teams
./scripts/linux/add-usersandteams.sh

exit 0