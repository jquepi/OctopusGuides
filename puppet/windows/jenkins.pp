file { 'C:/program Files (x86)/Jenkins/init.groovy.d':
  ensure => 'directory',
}
-> file { 'C:/Program Files (x86)/Jenkins/init.groovy.d/a.security.groovy':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    #!groovy
    import java.util.logging.Level
    import java.util.logging.Logger
    import hudson.security.*
    import jenkins.model.*

    def instance = Jenkins.getInstance()
    def logger = Logger.getLogger(Jenkins.class.getName())
    def hudsonRealm = new HudsonPrivateSecurityRealm(false)
    def users = hudsonRealm.getAllUsers().collect { it.toString() }

    if ("jenkinsadmin" in users) {
      logger.log(Level.INFO, "User 'jenkinsadmin' already exists.")
    } else {
      logger.log(Level.INFO, "Creating local admin user 'jenkinsadmin'.")
      hudsonRealm.createAccount("jenkinsadmin", "Password01!")
      def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
      strategy.setAllowAnonymousRead(false)
      instance.setSecurityRealm(hudsonRealm)
      instance.setAuthorizationStrategy(strategy)
      instance.save()
    }

    | EOT
}
-> file { 'C:/Program Files (x86)/Jenkins/init.groovy.d/b.plugins.groovy':
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
-> file_line { 'installStateName':
  path    => 'C:/Program Files (x86)/Jenkins/config.xml',
  line    => '  <installStateName>RUNNING</installStateName>',
  match   => '^\s*<installStateName>NEW</installStateName>',
  replace => true,
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