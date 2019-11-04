file { 'C:/tools/vsts-agent-win-x86-2.144.2':
  ensure => 'directory'
}
-> archive { 'C:/tools/vsts-agent-win-x86-2.144.2.zip':
  ensure       => present,
  extract      => true,
  extract_path => 'C:/tools/vsts-agent-win-x86-2.144.2',
  source       => 'https://go.microsoft.com/fwlink/?linkid=2066763',
  creates      => 'C:/tools/vsts-agent-win-x86-2.144.2/run.cmd',
  cleanup      => true,
}
-> file { 'C:/install_azure_agent.ps1':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    Write-Host "Configuring Azure DevOps agent"
    C:\tools\vsts-agent-win-x86-2.144.2\config.cmd --unattended --url http://localhost:9090 --auth integrated --pool default --agent myAgent
    Write-Host "Starting Azure DevOps agent"
    start "C:\tools\vsts-agent-win-x86-2.144.2\run.cmd" -PassThru
    New-Item -ItemType file c:\AzureAgentStarted.txt
    exit 0
    | EOT
}
-> exec { 'Configure agent':
  command   => '& C:/install_azure_agent.ps1',
  creates   => 'c:/AzureAgentStarted.txt',
  provider  => powershell,
  logoutput => true
}