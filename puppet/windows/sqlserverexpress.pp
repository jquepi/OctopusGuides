download_file { 'SQLEXPR_x64_ENU.ex':
  destination_directory => 'C:/tools',
  url                   =>
    'https://octopus-guides.s3.amazonaws.com/sqlserver/SQLEXPR_x64_ENU.exe',
}
-> file { 'C:/install_sql.ps1':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    Start-Process "C:\tools\SQLEXPR_x64_ENU.ex" -ArgumentList @("/IACCEPTSQLSERVERLICENSETERMS", "/Q", "/ACTION=install", "/INSTANCEID=SQLEXPRESS", "/INSTANCENAME=SQLEXPRESS", "/UPDATEENABLED=FALSE") -NoNewWindow -Wait
    New-Item -ItemType file c:\SqlInstalled.txt
    | EOT
}
-> exec { 'Install SQLServer':
  command   => '& C:/install_azure.ps1',
  creates   => 'c:/SqlInstalled.txt',
  timeout   => 3600,
  provider  => powershell,
  logoutput => true
}