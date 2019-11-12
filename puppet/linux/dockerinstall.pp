apt::key { 'docker-repository':
  id     => '9DC858229FC7DD38854AE2D88D81803C0EBFCD88',
  source => 'https://download.docker.com/linux/ubuntu/gpg',
  server  => 'pgp.mit.edu'
}
-> apt::source { 'docker':
  comment  => 'This is the docker repository',
  location => 'https://download.docker.com/linux/ubuntu',
  release  => '',
  repos    => 'bionic stable',
  key      => {
    'id' => '9DC858229FC7DD38854AE2D88D81803C0EBFCD88',
  },
  include  => {
    'deb' => true,
  },
}
-> package { 'apt-transport-https':
  ensure => installed,
}
-> package { 'ca-certificates':
  ensure => installed,
}
-> package { 'curl':
  ensure => installed,
}
-> package { 'gnupg-agent':
  ensure => installed,
}
-> package { 'software-properties-common':
  ensure => installed,
}
-> package { 'docker-ce':
  ensure => installed,
}
-> package { 'docker-ce-cli':
  ensure => installed,
}
-> package { 'containerd.io':
  ensure => installed,
}