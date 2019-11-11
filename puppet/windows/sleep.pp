exec { 'Sleep for a bit':
  command  => 'Start-Sleep 180',
  provider => powershell,
}