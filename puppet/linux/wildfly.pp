user { 'wildfly':
  ensure => present,
}
-> file { '/opt/wildfly':
  ensure => 'directory'
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
-> file { '/opt/wildfly':
  ensure  => directory,
  recurse => true,
  owner   => 'wildfly',
  group   => 'wildfly'
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
-> service { 'wildfly':
  ensure => 'running',
  enable => true,
}