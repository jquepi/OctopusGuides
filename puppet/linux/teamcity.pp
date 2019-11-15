archive { '/opt/TeamCity-2019.1.4.tar.gz':
  ensure          => present,
  extract         => true,
  extract_path    => '/opt',
  source          => 'https://octopus-guides.s3.amazonaws.com/teamcity/TeamCity-2019.1.4.tar.gz',
  creates         => '/opt/TeamCity/TeamCity-readme.txt',
  cleanup         => true,
  extract_command => 'tar xfz %s'
}
-> file { '/opt/start_teamcity.sh':
  ensure  => 'file',
  owner   => 'root',
  group   => 'root',
  mode    => '0755',
  content => @(EOT)
    /opt/TeamCity/bin/runAll.sh start &
    touch /opt/TeamCityStarted.txt
    exit 0
    | EOT
}
-> exec { 'Start TeamCity':
  command   => '/opt/start_teamcity.sh',
  creates   => '/opt/TeamCityStarted.txt',
  provider  => powershell,
  logoutput => true
}