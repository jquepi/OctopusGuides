exec { 'Wait For Artifactory':
  command   => 'for ($x = 0; $x -lt 15; ++$x) {if ((Test-NetConnection -ComputerName localhost -Port 8041).TcpTestSucceeded) {exit 0;}; Write-Host "Sleeping..."; Start-Sleep 30;} exit 1;',
  provider  => powershell,
  logoutput => true,
  timeout   => 600,
}