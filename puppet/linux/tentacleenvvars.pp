file_line { 'Add JAVA_HOME env var to tentacle service':
  path    => '/etc/systemd/system/Tentacle.service',
  line    => 'Environment="JAVA_HOME=\usr\lib\jvm\java-13-openjdk-amd64"',
  after   => '\[Service\]"',
  notify  => Service['Tentacle']
}
-> exec { 'Reload daemon':
  command   => '/bin/systemctl daemon-reload',
  logoutput => true
}

service {'Tentacle':
  ensure => running
}