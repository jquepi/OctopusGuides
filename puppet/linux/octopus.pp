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
  remove_container_on_start => false,
  remove_volume_on_start    => false,
  remove_container_on_stop  => false,
  remove_volume_on_stop     => false,
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

docker::image { 'octopusdeploy/octopusdeploy':
  image_tag => '2020.2.10'
}
-> exec { 'Initialise the database (this can take a few mins)':
  command =>
    "/usr/bin/docker run -e ACCEPT_EULA=Y --entrypoint /bin/bash octopusdeploy/octopusdeploy:2020.2.10 -al -c 'dotnet Octopus.Server.dll create-instance --instance OctopusServer --config \'/home/octopus/.octopus/OctopusServer/Server/Server.linux.config\' --serverNodeName=test; dotnet Octopus.Server.dll database --instance OctopusServer --connectionString \'Server=mssql,1433;Database=Octopus;User Id=SA;Password=Password01!\' --masterKey \'6EdU6IWsCtMEwk0kPKflQQ==\' --create'"
  ,
  timeout => 600
}
-> docker::run { 'octopusdeploy':
  image                     => 'octopusdeploy/octopusdeploy:2020.2.10',
  depends                   => 'mssql',
  env                       => ['ADMIN_USERNAME=admin', 'ADMIN_EMAIL=octopusguides@gmail.com',
    'ADMIN_PASSWORD=Password01!', 'ACCEPT_EULA=Y'
    , 'DB_CONNECTION_STRING=Server=mssql,1433;Database=Octopus;User Id=SA;Password=Password01!;ConnectRetryCount=6',
    'MASTER_KEY=6EdU6IWsCtMEwk0kPKflQQ=='],
  ports                     => ['80:8080', '10943:10943'],
  net                       => 'octopus',
  extra_parameters          => [ '--restart=always' ],
  labels                    => ['autoheal=true'],
  remove_container_on_start => false,
  remove_volume_on_start    => false,
  remove_container_on_stop  => false,
  remove_volume_on_stop     => false,
}
-> exec { 'enable service octopus':
  command   => '/bin/systemctl enable docker-octopusdeploy',
  logoutput => true
}
-> file_line { 'Octopus always restart':
  path    => '/etc/systemd/system/docker-octopusdeploy.service',
  line    => 'Restart=always',
  match   => 'Restart=on-failure',
  replace => true,
}