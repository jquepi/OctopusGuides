exec { 'Placeholder':
  provider  => 'powershell',
  command   => 'Write-Host "Nothing to see here"',
  logoutput => true
}