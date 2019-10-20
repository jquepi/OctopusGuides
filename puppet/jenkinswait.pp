exec { 'Wait For Jenkins':
  command   => 'for ($x = 0; $x -lt 30; ++$x) {if ((Test-NetConnection -Port 8080).TcpTestSucceeded) {exit 0;}; Write-Host "Sleeping...";} exit 1;',
  provider  => powershell,
  logoutput => true
}