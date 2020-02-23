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
  remove_container_on_start => false,
  remove_volume_on_start    => false,
  remove_container_on_stop  => false,
  remove_volume_on_stop     => false,
}
-> exec { 'enable service docker-mssql':
  command   => '/bin/systemctl enable docker-mssql',
  logoutput => true
}

docker::image { 'octopusdeploy/octopusdeploy':
  image_tag => '2019.13.7-linux'
}
-> docker::run { 'initdb':
  image   => 'octopusdeploy/octopusdeploy:2019.13.7-linux',
  restart => 'always',
  command =>
    'dotnet Octopus.Server.dll database --instance OctopusServer --masterKey "6EdU6IWsCtMEwk0kPKflQQ==" --connectionString "mssql,1433;Database=Octopus;User Id=SA;Password=Password01!"  --create'
}
-> docker::run { 'octopusdeploy':
  image                     => 'octopusdeploy/octopusdeploy:2019.13.7-linux',
  depends                   => 'mssql',
  env                       => ['ADMIN_USERNAME=admin', 'ADMIN_EMAIL=octopusguides@gmail.com',
    'ADMIN_PASSWORD=Password01!', 'ACCEPT_EULA=Y'
    , 'DB_CONNECTION_STRING=Server=mssql,1433;Database=Octopus;User Id=SA;Password=Password01!',
    'MASTER_KEY=6EdU6IWsCtMEwk0kPKflQQ=='],
  ports                     => ['80:8080', '10943:10943'],
  net                       => 'octopus',
  extra_parameters          => [ '--restart=on-failure' ],
  restart_on_unhealthy      => true,
  remove_container_on_start => false,
  remove_volume_on_start    => false,
  remove_container_on_stop  => false,
  remove_volume_on_stop     => false,
}
-> exec { 'enable service octopus':
  command   => '/bin/systemctl enable docker-octopusdeploy',
  logoutput => true
}