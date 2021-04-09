# to find the ID, run
# gpg --show-keys .\apt-key.gpg
apt::key { 'kubernetes-repository':
  id     => '59FE0256827269DC81578F928B57C5C2836F4BEB',
  source => 'https://packages.cloud.google.com/apt/doc/apt-key.gpg',
  server  => 'pgp.mit.edu'
}
-> apt::source { 'kubernetes':
  comment  => 'This is the kubernetes repository',
  location => 'http://apt.kubernetes.io/',
  release  => '',
  repos    => 'kubernetes-xenial main',
  key      => {
    'id' => '59FE0256827269DC81578F928B57C5C2836F4BEB',
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
-> package { 'conntrack':
  ensure => installed,
}
-> package { 'iptables-persistent':
  ensure => installed,
}
-> exec { 'Install MicroK8s':
  command   => '/usr/bin/snap install microk8s --classic',
  logoutput => true
}
-> exec { 'Extract cert':
  command   => '/snap/bin/microk8s.kubectl config view --raw -o json | jq -r \'.clusters[0].cluster."certificate-authority-data"\' | tr -d \'"\' | base64 --decode > /tmp/ca.crt',
  logoutput => true
}
-> exec { 'Enable DNS':
  command   => '/snap/bin/microk8s.enable dns',
  logoutput => true
}
-> exec { 'Enable registry':
  command   => '/snap/bin/microk8s.enable registry',
  logoutput => true
}
-> exec { 'Enable iptables forwarding':
  command   => '/sbin/iptables -P FORWARD ACCEPT',
  logoutput => true
}
-> file { '/etc/docker/daemon.json':
  content => @("EOL"/L)
    {
      "insecure-registries" : ["localhost:32000"]
    }
    | EOL
}
-> exec { 'Restart docker':
  command => '/bin/systemctl restart docker',
  logoutput => true
}
-> file { '/home/vagrant/.kube':
  ensure => 'directory',
  owner   => 'vagrant',
  group   => 'vagrant',
}
-> exec { 'Make config generally available':
  command   => '/snap/bin/microk8s.kubectl config view --raw > /home/vagrant/.kube/config',
  logoutput => true
}
