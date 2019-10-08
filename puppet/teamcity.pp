archive { 'C:/tools/TeamCity-2019.1.3.tar.gz':
  ensure          => present,
  extract         => true,
  extract_path    => 'C:/tools',
  source          => 'https://octopus-guides.s3.amazonaws.com/teamcity/TeamCity-2019.1.3.tar.gz',
  creates         => 'C:/tools/TeamCity/TeamCity-readme.txt',
  cleanup         => true,
  extract_command => 'tar xfz %s'
}
-> file { 'C:/start_teamcity.ps1':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    start "C:\tools\TeamCity\bin\runAll.bat" -ArgumentList "start" -PassThru
    exit 0
    | EOT
}
-> exec { 'Start TeamCity':
  command  => '& C:/start_teamcity.ps1',
  provider => powershell,
}