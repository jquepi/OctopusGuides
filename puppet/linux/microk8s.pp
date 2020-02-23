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
-> package { 'openssl':
  ensure => installed,
}
-> exec { 'Install MicroK8s':
  command   => '/usr/bin/snap install microk8s --classic',
  logoutput => true
} -> exec { 'Extract cert':
  command   => 'microk8s.kubectl config view --raw -o json | jq -r \'.clusters[0].cluster."certificate-authority-data"\' | tr -d \'"\' | base64 --decode > /tmp/ca.crt',
  logoutput => true
}

