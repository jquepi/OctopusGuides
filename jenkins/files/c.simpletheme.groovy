#!groovy
import jenkins.model.Jenkins;
import org.jenkinsci.plugins.simpletheme.CssUrlThemeElement;
import java.util.logging.Logger;
import java.util.logging.Level;

Jenkins jenkins = Jenkins.get()
def logger = Logger.getLogger(Jenkins.class.getName())
def themeDecorator = jenkins.getExtensionList(org.codefirst.SimpleThemeDecorator.class).first()

if (themeDecorator.getElements().stream().anyMatch{it -> it instanceof CssUrlThemeElement}) {
    logger.log(Level.INFO, "Simple theme already has a CSS URL.")
} else {
    logger.log(Level.INFO, "Setting simple theme CSS URL.")
    themeDecorator.setElements([
            new CssUrlThemeElement('https://cdn.rawgit.com/afonsof/jenkins-material-theme/gh-pages/dist/material-blue.css')
    ])
    jenkins.save()
}