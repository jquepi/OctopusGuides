file { 'C:/ProgramData/JetBrains':
  ensure => 'directory'
}
-> file { 'C:/ProgramData/JetBrains/TeamCity':
  ensure => 'directory'
}
-> file { 'C:/ProgramData/JetBrains/TeamCity/plugins':
  ensure => 'directory'
}
-> download_file { 'Octopus.TeamCity.zip':
  destination_directory => 'C:/ProgramData/JetBrains/TeamCity/plugins',
  url                   => 'https://octopus-guides.s3.amazonaws.com/teamcity/Octopus.TeamCity.zip',
}
-> archive { 'C:/tools/TeamCity-2019.1.3.tar.gz':
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
    New-Item -ItemType file c:\TeamCityStarted.txt
    exit 0
    | EOT
}
-> exec { 'Start TeamCity':
  command  => '& C:/start_teamcity.ps1',
  creates => 'C:/TeamCityStarted.txt',
  provider => powershell,
}