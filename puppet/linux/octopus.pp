docker::image { 'octopusdeploy/octopusdeploy':
  image_tag => '2020.3.2'
}
-> docker::run { 'octopusdeploy':
  image                     => 'octopusdeploy/octopusdeploy:2020.3.2',
  depends                   => 'mssql',
  env                       => ['ADMIN_USERNAME=admin', 'ADMIN_EMAIL=octopusguides@gmail.com',
    'ADMIN_PASSWORD=Password01!', 'ACCEPT_EULA=Y'
    , 'DB_CONNECTION_STRING=Server=mssql,1433;Database=Octopus;User Id=SA;Password=Password01!;ConnectRetryCount=6',
    'MASTER_KEY=6EdU6IWsCtMEwk0kPKflQQ==', 'DISABLE_DIND=Y'],
  ports                     => ['80:8080', '10943:10943'],
  net                       => 'octopus',
  extra_parameters          => [ '--restart=always' ],
  labels                    => ['autoheal=true'],
  remove_container_on_start => false,
  remove_volume_on_start    => false,
  remove_container_on_stop  => false,
  remove_volume_on_stop     => false,
  privileged                => false
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
