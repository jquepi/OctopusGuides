exec { 'Wait For Azure Devops':
  command   => 'for ($x = 0; $x -lt 15; ++$x) {if ((Test-NetConnection -ComputerName localhost -Port 9090).TcpTestSucceeded) {exit 0;}; Write-Host "Sleeping...";} Write-Host "Failed to access server"; exit 1;',
  provider  => powershell,
  logoutput => true,
  timeout   => 600,
}