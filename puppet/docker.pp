package { 'docker-for-windows':
  ensure   => installed,
  provider => chocolatey
}
-> exec { 'Switch to Linux containers':
  provider => 'powershell',
  command  => '& $Env:ProgramFiles\Docker\Docker\DockerCli.exe -SwitchDaemon'
}