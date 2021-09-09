exec { 'Get logs':
  command   => 'cat amps-standalone-bamboo-LATEST\target\bamboo-LATEST.log',
  logoutput => true
}
-> exec { 'Wait For Bamboo':
  command   => 'for ($x = 0; $x -lt 10; ++$x) {if ((Test-NetConnection -ComputerName localhost -Port 6990).TcpTestSucceeded) {exit 0;}; Write-Host "Sleeping..."; Sleep 60} exit 1;',
  provider  => powershell,
  logoutput => true,
  timeout   => 600,
}