exec { 'Sleep for a bit':
  command  => 'Start-Sleep 120',
  provider => powershell,
}