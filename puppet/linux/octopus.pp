docker::image { 'mcr.microsoft.com/mssql/server':
  image_tag => '2017-latest-ubuntu'
}
-> docker::run { 'mssql':
  image => 'mcr.microsoft.com/mssql/server:2017-latest-ubuntu',
  env   => ['ACCEPT_EULA=Y', 'SA_PASSWORD=Password01!', 'MSSQL_PID=Express'],
  ports => [1433],
  expose => [1433]
}
-> docker::image { 'octopusdeploy/linuxoctopus':
  image_tag => '2019.10.5'
}
-> docker::run { 'octopusdeploy':
  image => 'octopusdeploy/linuxoctopus:2019.10.5',
  env   => ['ADMIN_USERNAME=admin', 'ADMIN_EMAIL=octopusguides@gmail.com', 'ADMIN_PASSWORD=Password01!', 'ACCEPT_EULA=Y', 'CONNSTRING=Server=127.0.0.1,1433;Database=Octopus;User Id=SA;Password=Password01!'],
  ports => [80],
  expose => [80]
}