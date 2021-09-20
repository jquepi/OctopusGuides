file { 'C:/Program Files/Jenkins/init.groovy.d':
  ensure => 'directory',
}
-> file { 'C:/Program Files/Jenkins/init.groovy.d/b.plugins.groovy':
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
-> file_line { 'jenkins args':
  path    => 'C:/Program Files/Jenkins/jenkins.xml',
  line    =>
    '  <arguments>-Xrs -Xmx256m -Djenkins.install.runSetupWizard=false -Dhudson.lifecycle=hudson.lifecycle.WindowsServiceLifecycle -jar "C:\Program Files\Jenkins\jenkins.war" --httpPort=8080 --webroot="%LocalAppData%\Jenkins\war" --argumentsRealm.passwd.admin=Password01! --argumentsRealm.roles.admin=admin</arguments>'
  ,
  match   => '^\s*<arguments>.+?</arguments>',
  replace => true
}
-> file_line { 'Use container security':
  path    => 'C:/Windows/System32/config/systemprofile/AppData/Local/Jenkins/.jenkins/config.xml',
  line    => '  <authorizationStrategy class="hudson.security.LegacyAuthorizationStrategy"/>',
  match   => '^\s*<authorizationStrategy.*?/?>',
  replace => true
}
-> file_line { 'Remove authorizationStrategy contents':
  path   => 'C:/Windows/System32/config/systemprofile/AppData/Local/Jenkins/.jenkins/config.xml',
  line   => '^\s*<denyAnonymousReadAccess>true</denyAnonymousReadAccess>',
  ensure => absent,
  match_for_absence => true
}
-> file_line { 'Remove authorizationStrategy end tag':
  path   => 'C:/Windows/System32/config/systemprofile/AppData/Local/Jenkins/.jenkins/config.xml',
  match  => '^\s*</authorizationStrategy>',
  ensure => absent,
  match_for_absence => true
}
-> file_line { 'Legacy realm':
  path    => 'C:/Windows/System32/config/systemprofile/AppData/Local/Jenkins/.jenkins/config.xml',
  line    => '  <securityRealm class="hudson.security.LegacySecurityRealm"/>',
  match   => '^\s*<securityRealm.*?/?>',
  replace => true
}
-> file_line { 'Remove securityRealm contents 1':
  path   => 'C:/Windows/System32/config/systemprofile/AppData/Local/Jenkins/.jenkins/config.xml',
  match  => '^\s*<disableSignup>true</disableSignup>',
  ensure => absent,
  match_for_absence => true
}
-> file_line { 'Remove securityRealm contents 2':
  path   => 'C:/Windows/System32/config/systemprofile/AppData/Local/Jenkins/.jenkins/config.xml',
  match  => '^\s*<enableCaptcha>false</enableCaptcha>',
  ensure => absent,
  match_for_absence => true
}
-> file_line { 'Remove securityRealm end tag':
  path   => 'C:/Windows/System32/config/systemprofile/AppData/Local/Jenkins/.jenkins/config.xml',
  match  => '^\s*</securityRealm>',
  ensure => absent,
  match_for_absence => true
}
-> exec { 'Restart Jenkins':
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