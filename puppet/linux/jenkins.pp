apt::key { 'jenkins-repository':
  id     => '150FDE3F7787E7D11EF4E12A9B7D32F2D50582E6',
  source => 'https://pkg.jenkins.io/debian/jenkins-ci.org.key',
  server  => 'pgp.mit.edu'
}
-> apt::source { 'jenkins':
  comment  => 'This is the jenkins repository',
  location => 'http://pkg.jenkins.io/debian-stable',
  release  => '',
  repos    => 'binary/',
  key      => {
    'id' => '150FDE3F7787E7D11EF4E12A9B7D32F2D50582E6',
  },
  include  => {
    'deb' => true,
  },
}
-> exec { 'Update apt repo':
  command   => '/usr/bin/apt-get update',
  logoutput => true
}
-> package { 'jenkins':
  ensure => installed,
}

service { 'jenkins':
  ensure  => 'running',
  enable  => true,
}

file { '/var/lib/jenkins/init.groovy.d':
  ensure => 'directory',
}
-> file { '/var/lib/jenkins/init.groovy.d/a.security.groovy':
  notify  => Service['jenkins'],
  ensure  => 'file',
  owner   => 'root',
  group   => 'root',
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
-> file { '/var/lib/jenkins/init.groovy.d/b.plugins.groovy':
  notify  => Service['jenkins'],
  ensure  => 'file',
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  content => @(EOT)
    #!groovy
    import hudson.model.UpdateSite
    import hudson.PluginWrapper
    import jenkins.model.*
    import hudson.util.*
    import jenkins.install.*

    if (!Jenkins.instance.installState.isSetupComplete()) {
      InstallState.INITIAL_SETUP_COMPLETED.initializeState()
      Jenkins.instance.save()
    }

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
            Throwable error = plugin.deploy(dynamicLoad).get().getError()
            if(error != null) {
                println "ERROR installing ${it}, ${error}"
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