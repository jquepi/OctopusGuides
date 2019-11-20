apt::key { 'jenkins-repository':
  id     => '150FDE3F7787E7D11EF4E12A9B7D32F2D50582E6',
  source => 'https://pkg.jenkins.io/debian/jenkins-ci.org.key',
  server  => 'pgp.mit.edu'
}
-> apt::source { 'jenkins':
  comment  => 'This is the jenkins repository',
  location => 'http://pkg.jenkins.io/debian-stable',
  release  => '',
  repos    => 'binary',
  key      => {
    'id' => '150FDE3F7787E7D11EF4E12A9B7D32F2D50582E6',
  },
  include  => {
    'deb' => true,
  },
}
-> exec { 'Update apt repo':
  command   => '/usr/bin/apt-get update',
  logoutput => true
}
-> package { 'jenkins':
  ensure => installed,
}