exec { 'Get files':
  command   => 'Get-ChildItem .',
  provider  => powershell,
  logoutput => true
}
-> exec { 'Get files 2':
  command   => 'Get-ChildItem amps-standalone-bamboo-LATEST',
  provider  => powershell,
  logoutput => true
}
-> exec { 'Get files 3':
  command   => 'Get-ChildItem amps-standalone-bamboo-LATEST\target',
  provider  => powershell,
  logoutput => true
}
-> exec { 'Get logs':
  command   => 'Get-Content amps-standalone-bamboo-LATEST\target\bamboo-LATEST.log',
  provider  => powershell,
  logoutput => true
}
-> exec { 'Wait For Bamboo':
  command   => 'for ($x = 0; $x -lt 10; ++$x) {if ((Test-NetConnection -ComputerName localhost -Port 6990).TcpTestSucceeded) {exit 0;}; Write-Host "Sleeping..."; Sleep 60} exit 1;',
  provider  => powershell,
  logoutput => true,
  timeout   => 600,
}