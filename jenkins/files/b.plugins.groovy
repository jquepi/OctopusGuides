#!groovy
import hudson.model.UpdateSite
import hudson.PluginWrapper
import jenkins.model.*

// The list of plugins to install
Set<String> plugins_to_install = [
        "git", "github", "blueocean", "custom-tools-plugin", "simple-theme-plugin", "plain-credentials"
]

/*
  Install Jenkins plugins
*/
def install(Collection c, Boolean dynamicLoad, UpdateSite updateSite) {
    c.each {
        println "Installing ${it} plugin."
        UpdateSite.Plugin plugin = updateSite.getPlugin(it)
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