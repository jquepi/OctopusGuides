# Watch for unhealthy Octopus container and restart automatically
docker::image { 'willfarrell/autoheal':
  image_tag => 'latest'
}
-> docker::run { 'autoheal':
  image            => 'willfarrell/autoheal:latest',
  extra_parameters => [ '--restart=always' ],
  volumes          => ['/var/run/docker.sock:/var/run/docker.sock'],
  env              => ['AUTOHEAL_START_PERIOD=120'],
}
-> exec { 'enable service autoheal':
  command   => '/bin/systemctl enable docker-autoheal',
  logoutput => true
}
-> file_line { 'Autoheal always restart':
  path    => '/etc/systemd/system/docker-autoheal.service',
  line    => 'Restart=always',
  match   => 'Restart=on-failure',
  replace => true,
}