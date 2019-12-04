package { 'tomcat9':
  ensure => installed,
}
-> package { 'tomcat9-admin':
  ensure => installed,
}
-> file_line { 'Change Tomcat Port':
  path    => '/etc/tomcat9/server.xml',
  line    => '    <Connector port="9091" protocol="HTTP/1.1"',
  match   => '^\s*<Connector\ port\="8080"\ protocol\="HTTP/1.1"',
  replace => true,
  notify  => Service['tomcat9']
}
-> file_line { 'Add Tomcat User':
  path    => '/etc/tomcat9/tomcat-users.xml',
  line    => '<role rolename="manager-gui"/><role rolename="manager-script"/><user username="tomcat" password="Password01!" roles="manager-script,manager-gui"/></tomcat-users>',
  match   => '^</tomcat-users>',
  replace => true,
  notify  => Service['tomcat9']
}
-> file_line { 'Define config name':
  path    => '/lib/systemd/system/tomcat9.service',
  line    => 'Environment="SPRING_CONFIG_NAME=deployed-application"',
  after   => 'Environment\="JAVA_OPTS\=-Djava.awt.headless=true"',
  notify  => Service['tomcat9']
}
-> exec { 'Reload daemon':
  command   => '/bin/systemctl daemon-reload',
  logoutput => true
}
-> exec { 'Print users':
  command   => '/bin/cat /etc/tomcat9/tomcat-users.xml',
  logoutput => true
}
-> exec { 'Print config':
  command   => '/bin/cat /etc/tomcat9/server.xml',
  logoutput => true
}

service {'tomcat9':
  ensure => running
}