exec { 'Wait For Azure Devops':
  command   => 'for ($x = 0; $x -lt 30; ++$x) {if ((Test-NetConnection -Port 9090).TcpTestSucceeded) {break}; Write-Host "Sleeping...";} ',
  provider  => powershell,
  logoutput => true
}