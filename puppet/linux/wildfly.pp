user { 'wildfly':
  ensure => present,
}
-> file { '/opt/wildfly':
  ensure => 'directory',
  owner   => 'wildfly',
  group   => 'wildfly'
}
-> archive { '/opt/wildfly-18.0.1.Final.tar.gz':
  ensure          => present,
  extract         => true,
  extract_path    => '/opt/wildfly',
  source          => 'https://octopus-guides.s3.amazonaws.com/wildfly/wildfly-18.0.1.Final.tar.gz',
  creates         => '/opt/wildfly/README.txt',
  cleanup         => true,
  extract_command => 'tar xfz %s --strip-components=1'
}
-> exec { "fix permissions":
  command   => "/bin/chown -R wildfly:wildfly /opt/wildfly",
  logoutput => true,
  timeout   => 3600
}
-> file { '/etc/systemd/system/wildfly.service':
  ensure => present,
  source => "/opt/wildfly/docs/contrib/scripts/systemd/wildfly.service",
}
-> file { '/etc/wildfly':
  ensure => 'directory'
}
-> file { '/etc/wildfly/wildfly.conf':
  ensure => present,
  source => "/opt/wildfly/docs/contrib/scripts/systemd/wildfly.conf",
}
-> file { '/opt/wildfly/bin/launch.sh':
  ensure => present,
  mode   => '0755',
  source => "/opt/wildfly/docs/contrib/scripts/systemd/launch.sh",
}
-> exec { 'Reload daemon':
  command   => '/bin/systemctl daemon-reload',
  logoutput => true
}
-> file_line { 'Configure HTTP port':
  path    => '/opt/wildfly/standalone/configuration/standalone.xml',
  line    => '        <socket-binding name="http" port="${jboss.http.port:7070}"/>',
  match   => '\s*<socket-binding name="http" port="${jboss.http.port:8080}"/>',
  replace => true,
}
-> file_line { 'Configure HTTPS port':
  path    => '/opt/wildfly/standalone/configuration/standalone.xml',
  line    => '        <socket-binding name="http" port="${jboss.http.port:7443}"/>',
  match   => '\s*<socket-binding name="https" port="${jboss.https.port:8443}"/>',
  replace => true,
}
-> service { 'wildfly':
  ensure => 'running',
  enable => true,
}