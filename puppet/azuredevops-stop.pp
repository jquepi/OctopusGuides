file { 'C:/stop_azuredevops.bat':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    "C:\Program Files\Azure DevOps Server 2019\Tools\TfsServiceControl.exe" quiesce
    | EOT
}
-> exec { 'Stop Azure Devops':
  command => 'C:\\Windows\\system32\\cmd.exe /c C:\\stop_azuredevops.bat'
}