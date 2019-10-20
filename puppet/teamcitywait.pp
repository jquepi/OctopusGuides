exec { 'Wait For Team City':
  command   => 'for ($x = 0; $x -lt 30; ++$x) {if ((Test-NetConnection -Port 8111).TcpTestSucceeded) {exit 0;}; Write-Host "Sleeping...";} exit 1',
  provider  => powershell,
  logoutput => true
}