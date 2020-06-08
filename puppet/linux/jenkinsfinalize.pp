service { 'jenkins':
  ensure => 'running',
  enable => true,
}

file_line { 'jenkins args':
  path    => '/etc/default/jenkins',
  line    =>
    'JENKINS_ARGS="--webroot=/var/cache/$NAME/war --httpPort=$HTTP_PORT --argumentsRealm.passwd.admin=Password01! --argumentsRealm.roles.admin=admin"'
  ,
  match   => 'JENKINS_ARGS="--webroot=/var/cache/\$NAME/war --httpPort=\$HTTP_PORT"',
  replace => true
}
-> file_line { 'Use container security':
  path    => '/var/lib/jenkins/config.xml',
  line    => '  <authorizationStrategy class="hudson.security.LegacyAuthorizationStrategy"/>',
  match   => '^\s*<authorizationStrategy.*?/>',
  replace => true
}
-> file_line { 'Legacy realm':
  path    => '/var/lib/jenkins/config.xml',
  line    => '  <securityRealm class="hudson.security.LegacySecurityRealm"/>',
  match   => '^\s*<securityRealm.*?/>',
  replace => true,
  notify => Service['jenkins']
}

# exec { 'Get logs':
#   command   => '/bin/cat /var/log/jenkins/jenkins.log;',
#   logoutput => true
# }