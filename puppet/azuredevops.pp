package { 'sql-server-express':
  ensure   => installed,
  provider => chocolatey
}

download_file { 'azuredevopsexpress2019.exe':
  destination_directory => 'C:/tools',
  url                   =>
    'https://octopus-guides.s3.amazonaws.com/azuredevops/azuredevopsexpress2019.exe',
}
-> file { 'C:/install_azure.bat':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    "C:\tools\azuredevopsexpress2019.exe" /silent
    "C:\Program Files\Azure DevOps Server 2019\Tools\TfsConfig" unattend /unattendfile:.\config\azuredevops.ini /continue
    | EOT
}
-> exec { 'Install Azure':
  command => 'C:\\Windows\\system32\\cmd.exe /c C:\\install_azure.bat',
}