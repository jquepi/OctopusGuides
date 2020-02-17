docker::run { 'registry':
  image                     => 'registry:latest',
  ports                     => ['5000:5000'],
  net                       => 'octopus',
  remove_container_on_start => false,
  remove_volume_on_start    => false,
  remove_container_on_stop  => false,
  remove_volume_on_stop     => false,
}
-> exec { 'enable service docker-registry':
  command   => '/bin/systemctl enable docker-registry',
  logoutput => true
}