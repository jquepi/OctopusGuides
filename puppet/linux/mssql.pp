docker_network { 'octopus':
  ensure   => present,
  driver   => 'bridge',
  subnet   => '192.168.200.0/24',
  gateway  => '192.168.200.1',
  ip_range => '192.168.200.0/24',
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
  remove_container_on_start => false,
  remove_volume_on_start    => false,
  remove_container_on_stop  => false,
  remove_volume_on_stop     => false,
  privileged                => false
}
-> file_line { 'MSSQL always restart':
  path                  => '/etc/systemd/system/docker-mssql.service',
  line                  => 'Restart=always',
  match                 => 'Restart=on-failure',
}
-> exec { 'enable service docker-mssql':
  command   => '/bin/systemctl enable docker-mssql',
  logoutput => true
}

# For some reason the initial boot of the mssql container fails in hyperv. The logs at https://gist.github.com/mcasperson/d642c27797bdd5cb478fc01394d89230
# are an example of this. The workaround is to stop the service, kill the container, and restart the service. Restarting the
# container leaves it in a corrupted state, and and subsequent restarts fail. The solution for now is to kill the docker-mssql service,
# stop and remove the mssql container, and restart the docker-mssql service. This second restart works fine, and the
# docker-octopusdeploy service can be restarted successfully.