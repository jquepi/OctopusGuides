exec { 'Get Jenkins service status':
  command => '/bin/systemctl status jenkins.service',
  logoutput => true
}

exec { 'Get service logs':
  command => '/bin/journalctl -u jenkins.service',
  logoutput => true
}