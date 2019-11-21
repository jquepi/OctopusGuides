exec { 'Get logs':
  command   => '/bin/cat /var/log/jenkins/jenkins.log;',
  logoutput => true
}