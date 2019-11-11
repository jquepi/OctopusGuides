package { 'apt-transport-https':
  ensure => installed,
}

file { '/usr/local/bin/minikube':
  source => 'https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64',
  mode => '0744'
}