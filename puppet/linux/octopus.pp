docker_network { 'octopus':
  ensure   => present,
  driver   => 'bridge',
  subnet   => '192.168.0.0/16',
  gateway  => '192.168.0.1',
  ip_range => '192.168.1.0/24',
}
-> docker::image { 'mcr.microsoft.com/mssql/server':
  image_tag => '2017-latest-ubuntu'
}
-> docker::run { 'mssql':
  image                     => 'mcr.microsoft.com/mssql/server:2017-latest-ubuntu',
  env                       => ['ACCEPT_EULA=Y', 'SA_PASSWORD=Password01!', 'MSSQL_PID=Express'],
  ports                     => ['1433:1433'],
  net                       => 'octopus',
  remove_container_on_start => true,
  remove_volume_on_start    => false,
  remove_container_on_stop  => true,
  remove_volume_on_stop     => false,
}
-> exec { 'enable service docker-mssql':
  command   => '/bin/systemctl enable docker-mssql',
  logoutput => true
}

docker::image { 'octopusdeploy/octopusdeploy':
  image_tag => '2019.13.5-linux'
}
-> docker::run { 'octopusdeploy':
  image                     => 'octopusdeploy/octopusdeploy:2019.13.5-linux',
  depends                   => 'mssql',
  env                       => ['ADMIN_USERNAME=admin', 'ADMIN_EMAIL=octopusguides@gmail.com',
    'ADMIN_PASSWORD=Password01!', 'ACCEPT_EULA=Y'
    , 'CONNSTRING=Server=mssql,1433;Database=Octopus;User Id=SA;Password=Password01!'],
  ports                     => ['80:8080', '10943:10943'],
  net                       => 'octopus',
  remove_container_on_start => true,
  remove_volume_on_start    => false,
  remove_container_on_stop  => true,
  remove_volume_on_stop     => false,
}
-> exec { 'enable service octopus':
  command   => '/bin/systemctl enable docker-octopusdeploy',
  logoutput => true
}