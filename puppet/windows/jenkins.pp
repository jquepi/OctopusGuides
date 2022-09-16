# In jenkinsinstall.pp we install Jenkins and change initial settings like the JENKINS_HOME
# variable. It takes a bit of time for Jenkins to restart and populate the new C:\JenkinsHome
# dir, so this script is run later in the process to modify the config.xml file.

file_line { 'Use container security':
  path    => 'C:/JenkinsHome/config.xml',
  line    => '  <authorizationStrategy class="hudson.security.LegacyAuthorizationStrategy"/>',
  match   => '^\s*<authorizationStrategy.*?/?>',
  replace => true
}
-> file_line { 'Remove authorizationStrategy contents':
  path   => 'C:/JenkinsHome/config.xml',
  line   => '^\s*<denyAnonymousReadAccess>true</denyAnonymousReadAccess>',
  ensure => absent,
  match_for_absence => true
}
-> file_line { 'Remove authorizationStrategy end tag':
  path   => 'C:/JenkinsHome/config.xml',
  match  => '^\s*</authorizationStrategy>',
  ensure => absent,
  match_for_absence => true
}
-> file_line { 'Legacy realm':
  path    => 'C:/JenkinsHome/config.xml',
  line    => '  <securityRealm class="hudson.security.LegacySecurityRealm"/>',
  match   => '^\s*<securityRealm.*?/?>',
  replace => true
}
-> file_line { 'Remove securityRealm contents 1':
  path   => 'C:/JenkinsHome/config.xml',
  match  => '^\s*<disableSignup>true</disableSignup>',
  ensure => absent,
  match_for_absence => true
}
-> file_line { 'Remove securityRealm contents 2':
  path   => 'C:/JenkinsHome/config.xml',
  match  => '^\s*<enableCaptcha>false</enableCaptcha>',
  ensure => absent,
  match_for_absence => true
}
-> file_line { 'Remove securityRealm end tag':
  path   => 'C:/JenkinsHome/config.xml',
  match  => '^\s*</securityRealm>',
  ensure => absent,
  match_for_absence => true
}
-> exec { 'Restart Jenkins after config updates':
  command   => 'C:\\Windows\\system32\\cmd.exe /c net stop Jenkins & net start Jenkins',
  logoutput => true
}
-> exec { 'Get Jenkins log':
  provider => 'powershell',
  command  => 'Get-Content C:\Jenkins\jenkins.out.log',
  logoutput => true
}
-> exec { 'Get Jenkins error log':
  provider => 'powershell',
  command  => 'Get-Content C:\Jenkins\jenkins.err.log',
  logoutput => true
}
