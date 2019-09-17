package { 'octopusdeploy.tentacle':
  ensure   => installed,
  provider => chocolatey
}
-> file { 'C:/install_tentacle.bat':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    "C:\Program Files\Octopus Deploy\Tentacle\Tentacle.exe" create-instance --instance "Tentacle" --config "C:\Octopus\Tentacle.config"
    "C:\Program Files\Octopus Deploy\Tentacle\Tentacle.exe" new-certificate --instance "Tentacle" --if-blank
    "C:\Program Files\Octopus Deploy\Tentacle\Tentacle.exe" configure --instance "Tentacle" --reset-trust
    "C:\Program Files\Octopus Deploy\Tentacle\Tentacle.exe" configure --instance "Tentacle" --app "C:\Octopus\Applications" --port "10933" --noListen "True"
    "C:\Program Files\Octopus Deploy\Tentacle\Tentacle.exe" polling-proxy --instance "Tentacle" --proxyEnable "False" --proxyUsername "" --proxyPassword "" --proxyHost "" --proxyPort ""
    "C:\Program Files\Octopus Deploy\Tentacle\Tentacle.exe" register-with --instance "Tentacle" --server "http://localhost" --name "LocalTentacle" --comms-style "TentacleActive" --server-comms-port "10943" --username "admin" --password "Password01!" --space "Default" --environment "Dev" --role "web" --policy "Default Machine Policy"
    "C:\Program Files\Octopus Deploy\Tentacle\Tentacle.exe" service --instance "Tentacle" --install --stop --start
    copy /y NUL C:\OctopusTentacleInstalled.txt >NUL
    | EOT
}
-> exec { 'Install Tentacle':
  command => 'C:\\Windows\\system32\\cmd.exe /c C:\\install_tentacle.bat',
  creates => 'C:/OctopusTentacleInstalled.txt',
}