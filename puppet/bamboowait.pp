exec { 'Wait For Bamboo':
  command   => 'for ($x = 0; $x -lt 30; ++$x) {if ((Test-NetConnection -Port 6990).TcpTestSucceeded) {break}; Write-Host "Sleeping...";} ',
  provider  => powershell,
  logoutput => true
}