file { 'C:/tools/teamcity':
  ensure    => 'directory',
}
-> archive { 'C:/tools/TeamCity-2019.1.3.tar.gz':
  ensure       => present,
  extract      => true,
  extract_path => 'C:/tools/teamcity',
  source       => 'https://octopus-guides.s3.amazonaws.com/teamcity/TeamCity-2019.1.3.tar.gz',
  creates      => 'C:/tools/teamcity/service.properties',
  cleanup      => true,
}
-> exec { 'Run TeamCity':
  command  => '& C:/tools/teamcity/runAll.bat start',
  provider => powershell,
}