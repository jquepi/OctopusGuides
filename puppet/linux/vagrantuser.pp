@user { 'vagrant':
  groups     => ['docker'],
  membership => minimum,
}

User <| title == vagrant |>

file { '/home/vagrant/.kube':
  ensure => 'directory',
}
-> exec { 'Create config file':
  command   => '/usr/bin/kubectl --kubeconfig /root/.kube/config config view --flatten > /home/vagrant/.kube/config',
  logoutput => true
}
-> file_line { 'Change minikube host':
  path    => '/home/vagrant/.kube/config',
  line    => '    server: https://localhost:8443',
  match   => '    server: .*',
  replace => true,
}
-> file { '/home/vagrant/.kube/config':
  ensure => 'file',
  owner  => 'vagrant',
  group  => 'vagrant',
  mode   => '0600',
}