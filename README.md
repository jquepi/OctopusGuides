This repository contains the scripts used to generate the media for the Octopus guides. The blog at 
https://octopus.com/blog/devops-documentation explains the process.

The custom WebDriver tool is documented at https://octopus.com/blog/selenium/0-toc/webdriver-toc.

See the [aspnet-azuredevops-artifactory-feed-azurewebsite-tfvc-video.yml](https://github.com/OctopusDeploy/OctopusGuides/blob/master/.github/workflows/aspnet-azuredevops-artifactory-feed-azurewebsite-tfvc-video.yml) 
file for a commented example.

The provisioning process can also be performed as a Vagrant script processor step to allow the resulting configuration
to be captured in a virtual machine. The `Vagrantfile` files under the [vagrant](https://github.com/OctopusDeploy/OctopusGuides/tree/master/vagrant) 
directory provide the necessary configuration to build the virtual machines, with the scripts in the 
[vm](https://github.com/OctopusDeploy/OctopusGuides/tree/master/vm) directory running through much the same process as 
the YAML files perform in GitHub Actions. 

This project has a pom.xml file referencing the WebDriverTraining GitHub Maven repository at https://github.com/OctopusDeploy/WebDriverTraining/packages/66445.
The IntelliJ cucumber plugin will scan the JAR file for step annotations to provide a rich Gherkin editor.

To have Maven download the JAR file, your GitHub credentials need to be defined in the ~/.m2/settings.xml file:

```xml
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                      http://maven.apache.org/xsd/settings-1.0.0.xsd">

  <activeProfiles>
    <activeProfile>github</activeProfile>
  </activeProfiles>

        <mirrors>
          <mirror>
            <id>repo1</id>
            <name>Mirror 1</name>
            <url>https://repo1.maven.org/maven2</url>
            <mirrorOf>central</mirrorOf>
          </mirror>
        </mirrors>
  
  <profiles>
    <profile>
      <id>github</id>
      <repositories>
        <repository>
          <id>central</id>
          <url>https://repo1.maven.org/maven2</url>
          <releases><enabled>true</enabled></releases>
          <snapshots><enabled>false</enabled></snapshots>
        </repository>
        <repository>
          <id>github</id>
          <name>GitHub OctopusDeploy Apache Maven Packages</name>
          <url>https://maven.pkg.github.com/OctopusDeploy/WebDriverTraining</url>
        </repository>
      </repositories>
    </profile>
  </profiles>

  <servers>
    <server>
      <id>github</id>
      <username>GithubUserName</username>
      <password>PersonalAccessToken</password>
    </server>
  </servers>
</settings>
```