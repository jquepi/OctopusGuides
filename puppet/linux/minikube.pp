/*
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
*/

file { '/usr/local/bin/minikube':
  source => 'https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64',
  mode   => '0755'
}
-> file { '/opt/start-minikube.sh':
  ensure  => 'file',
  mode    => '0744',
  content => @(EOT)
    #!/bin/bash
    sudo minikube start --vm-driver=none --ignore-preflight-errors=SystemVerification
    touch /opt/minikube-started
    | EOT
}
-> exec { 'Start minikube':
  command   => '/opt/start-minikube.sh',
  creates   => '/opt/minikube-started',
  timeout   => 3600,
  logoutput => true
}

apt::key { 'kubernetes-repository':
  id     => '54A647F9048D5688D7DA2ABE6A030B21BA07F4FB',
  source => 'https://packages.cloud.google.com/apt/doc/apt-key.gpg',
  server  => 'pgp.mit.edu'
}
-> apt::source { 'kubernetes':
  comment  => 'This is the kubernetes repository',
  location => 'http://apt.kubernetes.io/',
  release  => '',
  repos    => 'kubernetes-xenial main',
  key      => {
    'id' => '54A647F9048D5688D7DA2ABE6A030B21BA07F4FB',
  },
  include  => {
    'deb' => true,
  },
}
-> package { 'kubectl':
  ensure => installed,
}
