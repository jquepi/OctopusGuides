#!/usr/bin/env bash

# Java Jenkins Tomcat Builtin Feed

# Set the following environment variables before calling this script:
# DOCKER_USERNAME
# DOCKER_PASSWORD
# SMTP_PASSWORD

# For example:
# DOCKER_USERNAME=username DOCKER_PASSWORD=password SMTP_PASSWORD=password ./java-jenkins-tomcat.sh

export FACTER_dockerhub_user=$DOCKER_USERNAME
export FACTER_dockerhub_password=$DOCKER_PASSWORD

export DISPLAY=":99.0"

export SLACK_STEP_HANDLER=false
export DISABLE_HIGHLIGHTS=true
export DISABLE_SCREENSHOTS=true
export MOVE_TO_MOUSE_CURSOR=false
export DISABLE_VIDEO=true
export STHREE_SCREENSHOT_ENABLED=false
export STEP_PAUSE=1000
export MOUSE_VERTICAL_OFFSET=74

export CUCUMBER_TAGS="(not @browserspecific or @firefox) and (not @destinationspecific or @tomcat) and (not @repositoryspecific or @octo-built-in-feed) and (not @applicationspecific or @java) and (not @sourcespecific or @git)"

export GIT_URL=https://github.com/OctopusSamples/RandomQuotes-Java.git
export DOCKER_IMAGE=octopusdeploy/randomquotesjava
export CREATE_RELEASE_SHELL_LOCATOR="(//div[@class='CodeMirror'])[2]"

# Firefox can not be run as root, so create a user to run the webdriver scripts
useradd guides -s /bin/bash -p '*'

cd ..

# Install Puppet
./install.sh docker.pp dotnetutilities.pp utilities.pp jenkins.pp tomcat.pp dockercreds.pp octopus.pp octopuscli.pp jenkinsfinalize.pp

# Wait for Octopus
sudo -u guides ./scripts/linux/wait-octopus.sh

# Create Api Key
sudo -u guides ./scripts/linux/create-apikey.sh

# Create Jenkins project
sudo -u guides ./scripts/linux/create-javawar-jenkinsproject.sh

# Create environments
sudo -u guides ./scripts/linux/create-environments.sh

# Create Target
sudo -u guides ./scripts/linux/create-target.sh

# Create project
sudo -u guides ./scripts/linux/create-tomcatproject.sh

# Create release
sudo -u guides ./scripts/linux/create-jenkinscreaterelease.sh

# Create Lifecycle
sudo -u guides ./scripts/linux/create-lifecycle.sh

# Add Manual Intervention
sudo -u guides ./scripts/linux/add-manualintervention.sh

# Add Notification
sudo -u guides ./scripts/linux/add-notification.sh

# Add Users and Teams
sudo -u guides ./scripts/linux/add-usersandteams.sh