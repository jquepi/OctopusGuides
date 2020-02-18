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
  owner  => 'vagrant',
  group  => 'vagrant'
}
-> file_line { 'Update certificate authority':
  path    => '/home/vagrant/.kube/config',
  line    => '    certificate-authority: /root/.minikube/ca.crt',
  match   => '    certificate-authority: /home/vagrant/.minikube/ca.crt',
  replace => true
}
-> file_line { 'Update client certificate':
  path    => '/home/vagrant/.kube/config',
  line    => '    client-certificate: /root/.minikube/client.crt',
  match   => '    client-certificate: /home/vagrant/.minikube/ca.crt',
  replace => true
}
-> file_line { 'Update client key':
  path    => '/home/vagrant/.kube/config',
  line    => '    client-key: /root/.minikube/client.key',
  match   => '    client-key: /home/vagrant/.minikube/client.key',
  replace => true
}

file { '/home/vagrant/.minikube':
  ensure => 'directory',
}
-> file { '/home/vagrant/.minikube/client.crt':
  ensure => present,
  source => "/root/.minikube/client.crt",
  owner  => 'vagrant',
  group  => 'vagrant'
}
-> file { '/home/vagrant/.minikube/client.key':
  ensure => present,
  source => "/root/.minikube/client.key",
  owner  => 'vagrant',
  group  => 'vagrant'
}
-> file { '/home/vagrant/.minikube/ca.crt':
  ensure => present,
  source => "/root/.minikube/ca.crt",
  owner  => 'vagrant',
  group  => 'vagrant'
}