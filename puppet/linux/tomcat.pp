package { 'tomcat9':
  ensure => installed,
}
-> file_line { 'Change Tomcat Port':
  path    => '/usr/share/tomcat9/etc/server.xml',
  line    => '<Connector port="9091"',
  match   => '\s*<Connector port="9091"',
  replace => true,
}
-> service {'bamboo':
  ensure => running
}

