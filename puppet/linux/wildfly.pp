user { 'wildfly':
  ensure => present,
}
-> archive { '/opt/wildfly-18.0.1.Final.tar.gz':
  ensure          => present,
  extract         => true,
  extract_path    => '/opt',
  source          => 'https://octopus-guides.s3.amazonaws.com/wildfly/wildfly-18.0.1.Final.tar.gz',
  creates         => '/opt/wildfly-18.0.1.Final/README.txt',
  cleanup         => true,
  extract_command => 'tar xfz %s'
}
-> file { '/etc/systemd/system/wildfly.service':
  ensure => present,
  source => "/opt/wildfly-18.0.1.Final/docs/contrib/scripts/systemd/wildfly.service",
}
-> file { '/etc/wildfly':
  ensure => 'directory'
}
-> file { '/etc/wildfly/wildfly.conf':
  ensure => present,
  source => "/opt/wildfly-18.0.1.Final/docs/contrib/scripts/systemd/wildfly.conf",
}
-> file { '/opt/wildfly-18.0.1.Final/bin/launch.sh':
  ensure => present,
  mode   => '0755',
  source => "/opt/wildfly-18.0.1.Final/docs/contrib/scripts/systemd/launch.sh",
}
-> file_line { 'Fix ExecStart':
  path    => '/etc/systemd/system/wildfly.service',
  line    => 'ExecStart=/opt/wildfly-18.0.1.Final/bin/launch.sh $WILDFLY_MODE $WILDFLY_CONFIG $WILDFLY_BIND',
  match   => 'ExecStart=/opt/wildfly/bin/launch.sh \$WILDFLY_MODE \$WILDFLY_CONFIG \$WILDFLY_BIND',
  replace => true
}
-> exec { 'Reload daemon':
  command   => '/bin/systemctl daemon-reload',
  logoutput => true
}
-> service { 'wildfly':
  ensure => 'running',
  enable => true,
}