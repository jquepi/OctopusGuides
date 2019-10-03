host { 'devops.example.org':
  ip => '127.0.0.1',
}

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
  timeout => 3600,
}

file { 'C:/tools/vsts-agent-win-x86-2.144.2':
  ensure => 'directory'
}

archive { 'C:/tools/vsts-agent-win-x86-2.144.2.zip':
  ensure       => present,
  extract      => true,
  extract_path => 'C:/tools/vsts-agent-win-x86-2.144.2',
  source       => 'https://go.microsoft.com/fwlink/?linkid=2066763',
  creates      => 'C:/tools/vsts-agent-win-x86-2.144.2/run.cmd',
  cleanup      => true,
}

file { 'C:/install_azure_agent.ps1':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    C:\tools\vsts-agent-win-x86-2.144.2\config.cmd --unattended --url http://localhost:9090 --auth integrated --pool default --agent myAgent
    start C:\tools\vsts-agent-win-x86-2.144.2\run.cmd
    | EOT
}
-> exec { 'Configure agent':
  command  => '& C:/install_azure_agent.ps1',
  provider => powershell,
}