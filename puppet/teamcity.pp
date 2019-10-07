archive { 'C:/tools/TeamCity-2019.1.3.tar.gz':
  ensure          => present,
  extract         => true,
  extract_path    => 'C:/tools',
  source          => 'https://octopus-guides.s3.amazonaws.com/teamcity/TeamCity-2019.1.3.tar.gz',
  creates         => 'C:/tools/TeamCity/TeamCity-readme.txt',
  cleanup         => true,
  extract_command => 'tar xfz %s'
}
-> exec { 'Run TeamCity':
  command => 'C:\\Windows\\system32\\cmd.exe /c "C:\\tools\\TeamCity\\bin\\runAll.bat start"',
}