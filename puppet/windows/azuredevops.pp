host { 'devops.example.org':
  ip => '127.0.0.1',
}

-> file { 'C:/tools':
  ensure => 'directory'
}
-> download_file { 'azuredevopsserver2019.1.1_rc.exe':
  destination_directory => 'C:/tools',
  url                   =>
    'https://octopus-guides.s3.amazonaws.com/azuredevops/azuredevopsserver2019.1.1_rc.exe',
}
-> file { 'C:/install_azure.ps1':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    Start-Process "C:\tools\azuredevopsserver2019.1.1_rc.exe" -ArgumentList @("/silent") -NoNewWindow -Wait
    Start-Process "C:\Program Files\Azure DevOps Server 2019\Tools\TfsConfig.exe" -ArgumentList @("unattend", "/unattendfile:.\config\azuredevops.ini", "/continue") -NoNewWindow -Wait
    New-Item -ItemType file c:\AzureDevOpsStarted.txt
    | EOT
}
-> exec { 'Install Azure':
  command   => '& C:/install_azure.ps1',
  creates   => 'c:/AzureDevOpsStarted.txt',
  timeout   => 3600,
  provider  => powershell,
  logoutput => true
}