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

export CUCUMBER_TAGS="(not @browserspecific or @chrome) and (not @destinationspecific or @tomcat) and (not @repositoryspecific or @octo-built-in-feed) and (not @applicationspecific or @java) and (not @sourcespecific or @git)"
export CUCUMBER_PLUGIN=pretty

export GIT_URL=https://github.com/OctopusSamples/RandomQuotes-Java.git
export DOCKER_IMAGE=octopusdeploy/randomquotesjava
export CREATE_RELEASE_SHELL_LOCATOR="(//div[@class='CodeMirror'])[2]"

cd ..

# Install Puppet
./install.sh \
  jenkins.pp \
  wildfly.pp \
  update.pp \
  sleep.pp \
  jenkinsfinalize.pp \
  jenkinsicon.pp \
  wildflyicon.pp \
  octopusicon.pp \
  passwords.pp

exit 0