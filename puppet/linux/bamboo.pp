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
-> file { '/opt/start_bamboo.sh':
  ensure  => 'file',
  owner   => 'root',
  group   => 'root',
  mode    => '0755',
  content => @(EOT)
    #!/bin/bash
    mkdir -p /tmp/bamboo/target/classes
    cp config/pom.xml /tmp/bamboo
    cp config/atlassian-plugin.xml /tmp/bamboo/target/classes
    cd /tmp/bamboo
    touch /opt/BambooStarted.txt
    atlas-run
    | EOT
}
-> exec { 'Start Bamboo':
  command   => '/opt/start_bamboo.sh &',
  creates   => '/opt/BambooStarted.txt',
  logoutput => true
}