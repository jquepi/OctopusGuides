@user { 'vagrant':
  groups     => ['docker'],
  membership => minimum,
}

User <| title == vagrant |>

file { '/home/vagrant/.kube':
  ensure => 'directory',
}
-> exec { 'Create config file':
  command   => '/usr/bin/kubectl get config view --flatten > /home/vagrant/.kube/config',
  logoutput => true
}
-> file { '/home/vagrant/.kube/config':
  ensure => 'file',
  owner  => 'vagrant',
  group  => 'vagrant',
  mode   => '0600',
}