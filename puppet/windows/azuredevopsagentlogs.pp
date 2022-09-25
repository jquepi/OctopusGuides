exec { 'Get agent logs':
  command   => 'Get-ChildItem "C:\tools\vsts-agent\_diag" -Filter *.log | % {Get-Content $_.FullName}',
  creates   => 'c:/AzureAgentStarted.txt',
  provider  => powershell,
  logoutput => true
}