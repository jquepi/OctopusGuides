file { 'C:/azure_devops_logs.ps1':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    ls C:\tools\vsts-agent
    ls C:\tools\vsts-agent\_diag
    Get-ChildItem "C:\tools\vsts-agent\_diag" -Filter *.log | % {Get-Content $_.FullName}

    Get-Content C:\azuredevopsagent.out
    | EOT
}
-> exec { 'Get Azure DevOps Agent Logs':
  command   => '& C:/azure_devops_logs.ps1',
  provider  => powershell,
  logoutput => true
}