exec { 'Wait For Team City':
  command   => 'for ($x = 0; $x -lt 30; ++$x) {if ((Test-NetConnection -Port 8111).TcpTestSucceeded) {break}; Write-Host "Sleeping...";} ',
  provider  => powershell,
  logoutput => true
}