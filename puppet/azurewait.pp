exec { 'Wait For Azure Devops':
  command   => 'for ($x = 0; $x -lt 30; ++$x) {if ((Test-NetConnection -Port 9090).TcpTestSucceeded) {exit 0;}; Write-Host "Sleeping...";} exit 1;',
  provider  => powershell,
  logoutput => true
}