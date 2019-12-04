package { 'tomcat9':
  ensure => installed,
}
-> file_line { 'Change Tomcat Port':
  path    => '/usr/share/tomcat9/etc/server.xml',
  line    => '    <Connector port="9091" protocol="HTTP/1.1"',
  match   => '^\s*<Connector\ port\="8080"\ protocol\="HTTP/1.1"',
  replace => true,
}
-> file_line { 'Add Tomcat User':
  path    => '/usr/share/tomcat9/etc/tomcat-users.xml',
  line    => '<role rolename="manager-script"/><user username="tomcat" password="Password01!" roles="manager-script"/></tomcat-users>',
  match   => '^</tomcat-users>',
  replace => true,
}
-> service {'tomcat9':
  ensure => running
}

