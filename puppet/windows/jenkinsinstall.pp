# Install this early, as it takes a few minutes to initilaize
# Jenkins in chocolaty hasn't been updated in quite a while, so manually install

file { 'C:/JenkinsHome':
  ensure => 'directory'
}
-> file { 'C:/JenkinsHome/init.groovy.d':
  ensure => 'directory',
}
-> file { 'C:/JenkinsHome/init.groovy.d/b.plugins.groovy':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    #!groovy
    import hudson.model.UpdateSite
    import hudson.PluginWrapper
    import jenkins.model.*
    import hudson.util.*
    import jenkins.install.*

    // The list of plugins to install
    Set<String> plugins_to_install = [
        "git", "github", "credentials", "credentials-binding", "plain-credentials"
    ]

    /*
      Install Jenkins plugins
    */
    def install(Collection c, Boolean dynamicLoad, UpdateSite updateSite) {
        c.each {
            println "Installing ${it} plugin."
            UpdateSite.Plugin plugin = updateSite.getPlugin(it)

            // Wait for the future to be resolved, and check for any errors
            if (plugin != null) {
              Throwable error = plugin.deploy(dynamicLoad).get().getError()
              if(error != null) {
                  println "ERROR installing ${it}, ${error}"
              }
            } else {
              println "Could not find plugin ${it}"
            }
        }
        null
    }

    // Some useful vars to set
    Boolean hasConfigBeenUpdated = false

    // The default update site
    UpdateSite updateSite = Jenkins.getInstance().getUpdateCenter().getById('default')
    // Update the site
    updateSite.updateDirectlyNow(false)

    List<PluginWrapper> plugins = Jenkins.instance.pluginManager.getPlugins()

    //get a list of installed plugins
    Set<String> installed_plugins = []
    plugins.each {
      installed_plugins << it.getShortName()
    }

    //check to see if there are missing plugins to install
    Set<String> missing_plugins = plugins_to_install - installed_plugins
    if(missing_plugins.size() > 0) {
        println "Install missing plugins..."
        install(missing_plugins, true, updateSite)
        println "Done installing missing plugins."
        hasConfigBeenUpdated = true
    }

    if(hasConfigBeenUpdated) {
        println "Saving Jenkins configuration to disk."
        Jenkins.instance.save()
    } else {
        println "Jenkins up-to-date.  Nothing to do."
    }

    | EOT
}
-> download_file {'jenkins.msi':
  destination_directory => 'C:/tools',
  url => 'https://octopus-guides.s3.amazonaws.com/jenkins/jenkins.msi'
}
-> file { 'C:/start_jenkins.ps1':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    start-process msiexec -Wait -ArgumentList @("JAVA_HOME=C:\tools\zulu11.58.23-ca-jdk11.0.16.1-win_x64", "JENKINSDIR=C:\Jenkins", "/qn", "/norestart", "/l*v", "c:\jenkinsinstall.log", "/i", "c:\tools\jenkins.msi")
    Get-Content c:\jenkinsinstall.log
    New-Item -ItemType file c:\JenkinsStarted.txt
    exit 0
    | EOT
}
-> exec { 'Start Jenkins':
  command   => '& C:/start_jenkins.ps1',
  creates   => 'C:/JenkinsStarted.txt',
  provider  => powershell,
  logoutput => true
}
# Change the home directory, as MSBuild doesn't work well with paths like "C:\Windows\System32\config\systemprofile\AppData\Local\Jenkins\.jenkins"
# Otherwise you get errors like "MSBUILD : error MSB1009: Project file does not exist"
# Also, this is the only way to set JENKINS_HOME. See https://issues.jenkins.io/browse/JENKINS-13530
-> file_line { 'jenkins home':
  path    => 'C:/Jenkins/jenkins.xml',
  line    =>
    '  <env name="JENKINS_HOME" value="C:\JenkinsHome"/>'
  ,
  match   => '^\s*<env name="JENKINS_HOME".+?/>',
  replace => true
}
# Skip the initial wizard, and set the admin credentials. Also disable CSRF as it has caused issues in the past.
-> file_line { 'jenkins args':
  path    => 'C:/Jenkins/jenkins.xml',
  line    =>
    '  <arguments>-Xrs -Xmx256m -Dhudson.security.csrf.GlobalCrumbIssuerConfiguration.DISABLE_CSRF_PROTECTION=true -Djenkins.install.runSetupWizard=false -Dhudson.lifecycle=hudson.lifecycle.WindowsServiceLifecycle -jar "C:\Jenkins\jenkins.war" --httpPort=8080 --webroot="%LocalAppData%\Jenkins\war" --argumentsRealm.passwd.admin=Password01! --argumentsRealm.roles.admin=admin</arguments>'
  ,
  match   => '^\s*<arguments>.+?</arguments>',
  replace => true
}
-> exec { 'Restart Jenkins with new home dir':
  command   => 'C:\\Windows\\system32\\cmd.exe /c net stop Jenkins & net start Jenkins',
  logoutput => true
}
-> exec { 'Create Jenkins Shortcut':
  provider  => 'powershell',
  command   =>
    '$sh = New-Object -comObject WScript.Shell; $short = $sh.CreateShortcut($sh.SpecialFolders("Desktop") + "\\Jenkins.lnk"); $short.TargetPath = "http://localhost:8080"; $short.Save();'
  ,
  logoutput => true
}