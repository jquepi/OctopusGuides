docker::registry { 'https://index.docker.io/v1/':
  ensure => 'absent',
}