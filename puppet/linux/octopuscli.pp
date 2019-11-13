file { '/opt/octo':
  ensure => 'directory'
}
-> archive { '/opt/OctopusTools.6.14.2.portable.tar.gz':
  ensure       => present,
  extract      => true,
  extract_path => '/opt/octo',
  source       => 'https://download.octopusdeploy.com/octopus-tools/6.14.2/OctopusTools.6.14.2.portable.tar.gz',
  creates      => '/opt/octo/Octo',
  cleanup      => true,
}
-> file { '/opt/query-octopus.sh':
  ensure  => 'file',
  mode    => '0744',
  content => @(EOT)
    #!/bin/bash
    sleep 60
    /opt/octo/Octo list-machines --server http://localhost --user admin --pass Password01!
    | EOT
}
-> exec { 'Query Octopus':
  command   => '/opt/query-octopus.sh',
  logoutput => true
}