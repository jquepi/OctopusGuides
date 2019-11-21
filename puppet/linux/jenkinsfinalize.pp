exec { 'Get logs':
  command   => '/bin/sleep 300; /bin/cat /var/log/jenkins/jenkins.log;',
  logoutput => true
}
-> file_line { 'installStateName':
  path    => '/var/lib/jenkins/config.xml',
  line    => '  <installStateName>RUNNING</installStateName>',
  match   => '^\s*<installStateName>.*?</installStateName>',
  replace => true,
}
-> exec { 'Restart service':
  command   => '/bin/systemctl restart jenkins ',
  logoutput => true
}