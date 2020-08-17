docker_network { 'octopus':
  ensure   => present,
  driver   => 'bridge',
  subnet   => '192.168.0.0/16',
  gateway  => '192.168.0.1',
  ip_range => '192.168.1.0/24',
}
-> docker::image { 'mcr.microsoft.com/mssql/server':
  image_tag => '2019-latest'
}
-> docker::run { 'mssql':
  image                     => 'mcr.microsoft.com/mssql/server:2019-latest',
  env                       => ['ACCEPT_EULA=Y', 'SA_PASSWORD=Password01!', 'MSSQL_PID=Express', 'MSSQL_MEMORY_LIMIT_MB=2048'],
  ports                     => ['1433:1433'],
  net                       => 'octopus',
  extra_parameters          => [ '--restart=always' ],
  labels                    => ['autoheal=true'],
  # Remove everything before restarting. This gives a failed sql boot a chance to start fresh.
  remove_container_on_start => true,
  remove_volume_on_start    => true,
  remove_container_on_stop  => true,
  remove_volume_on_stop     => true,
  privileged                => false
}
-> exec { 'enable service docker-mssql':
  command   => '/bin/systemctl enable docker-mssql',
  logoutput => true
}
-> file_line { 'MSSQL always restart':
  path                  => '/etc/systemd/system/docker-mssql.service',
  line                  => 'Restart=always',
  match                 => 'Restart=on-failure',
}