apt::key { 'atlassian-repository':
  id     => 'D648E5571A519459EC58F888B56C9565957495B9',
  source => 'https://packages.atlassian.com/api/gpg/key/public',
  server  => 'pgp.mit.edu'
}
-> apt::source { 'atlassian':
  comment  => 'This is the atlassian repository',
  location => 'https://packages.atlassian.com/debian/atlassian-sdk-deb/',
  release  => '',
  repos    => 'stable contrib',
  key      => {
    'id' => 'D648E5571A519459EC58F888B56C9565957495B9',
  },
  include  => {
    'deb' => true,
  },
}
-> package { 'atlassian-plugin-sdk':
  ensure => installed,
}
-> file { '/opt/bamboo':
  ensure => 'directory',
}
-> file { '/opt/bamboo/target':
  ensure => 'directory',
}
-> file { '/opt/bamboo/target/classes':
  ensure => 'directory',
}
-> exec { 'copy pom':
  command => '/bin/cp config/pom.xml /opt/bamboo'
}
-> exec { 'copy plugin':
  command => '/bin/cp config/atlassian-plugin.xml /opt/bamboo/target/classes'
}
-> file { '/opt/bamboo/start_bamboo.sh':
  ensure  => 'file',
  owner   => 'root',
  group   => 'root',
  mode    => '0755',
  content => @(EOT)
    #!/bin/bash
    cd /opt/bamboo
    atlas-run
    | EOT
}
-> file { '/lib/systemd/system/bamboo.service':
  ensure  => 'file',
  owner   => 'root',
  group   => 'root',
  mode    => '0755',
  content => @(EOT)
    [Unit]
    Description=Bamboo

    [Service]
    ExecStart=/opt/bamboo/start_bamboo.sh
    | EOT
}
-> service {'bamboo':
  ensure => running
}