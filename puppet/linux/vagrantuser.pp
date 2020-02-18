@user { 'vagrant':
  groups     => ['docker'],
  membership => minimum,
}

User <| title == vagrant |>

file { '/home/vagrant/.kube':
  ensure => 'directory',
}
-> file { '/home/vagrant/.kube/config':
  ensure => present,
  source => "/root/.kube/config",
}

file { '/home/vagrant/.minikube':
  ensure => 'directory',
}
-> file { '/home/vagrant/.minikube/client.crt':
  ensure => present,
  source => "/root/.minikube/client.crt",
}
-> file { '/home/vagrant/.minikube/client.key':
  ensure => present,
  source => "/root/.minikube/client.key",
}