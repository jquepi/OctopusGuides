download_file { 'sdk-installer-8.0.16.exe':
  destination_directory => 'C:/tools',
  url                   =>
    'https://octopus-guides.s3.amazonaws.com/bamboo/sdk-installer-8.0.16.exe',
}
file { 'C:/bamboo':
  ensure => 'directory'
}
-> file { 'C:/start_bamboo.ps1':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    c:\tools\sdk-installer-8.0.16.exe -q -overwrite
    New-Item -ItemType Directory -Path C:\bamboo\target\classes -Force
    cp config/pom.xml c:\bamboo
    cp config/atlassian-plugin.xml C:\bamboo\target\classes
    cd c:\bamboo
    start "C:\Applications\Atlassian\atlassian-plugin-sdk-8.0.16\bin\atlas-run.bat" -PassThru
    New-Item -ItemType file c:\BambooStarted.txt
    exit 0
    | EOT
}
-> exec { 'Start Bamboo':
  command  => '& C:/start_bamboo.ps1',
  creates => 'C:/BambooStarted.txt',
  provider => powershell,
}