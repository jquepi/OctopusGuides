exec { 'Get logs':
  command   => '/bin/cat /var/log/jenkins/jenkins.log; ',
  logoutput => true
}
# -> exec { 'Restart service':
#   command   => '/bin/systemctl restart jenkins ',
#   logoutput => true
# }