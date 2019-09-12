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