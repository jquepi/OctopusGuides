exec { 'Wait For Jenkins':
  command   => 'for ($x = 0; $x -lt 30; ++$x) {if ((Test-NetConnection -Port 8080).TcpTestSucceeded) {break}; Write-Host "Sleeping...";} ',
  provider  => powershell,
  logoutput => true
}