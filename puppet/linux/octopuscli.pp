file { '/opt/octo':
  ensure => 'directory'
}
-> archive { '/opt/OctopusTools.7.4.1.linux-x64.tar.gz':
  ensure       => present,
  extract      => true,
  extract_path => '/opt/octo',
  source       => 'https://download.octopusdeploy.com/octopus-tools/7.4.1/OctopusTools.7.4.1.linux-x64.tar.gz',
  creates      => '/opt/octo/Octo',
  cleanup      => true,
}
# -> file { '/opt/query-octopus.sh':
#   ensure  => 'file',
#   mode    => '0744',
#   content => @(EOT)
#     #!/bin/bash
#     /opt/octo/Octo list-machines --server http://localhost --user admin --pass Password01!
#     | EOT
# }
# -> exec { 'Query Octopus':
#   command   => '/opt/query-octopus.sh',
#   logoutput => true
# }
