include chocolatey

file { 'C:/install/octopus.client.6.7.0':
  ensure => 'directory'
}
-> archive { 'C:/install/Octopus.Client.nupkg':
  ensure       => present,
  extract      => true,
  extract_path => 'C:/install/octopus.client.6.7.0',
  source       => 'https://www.nuget.org/api/v2/package/Octopus.Client/6.7.0',
  creates      => 'C:/install/octopus.client.6.7.0/Octopus.Client.nuspec',
  cleanup      => true,
}

file { 'C:/install/newtonsoft.json.9.0.1':
  ensure => 'directory'
}
-> archive { 'C:/install/Newtonsoft.Json.nupkg':
  ensure       => present,
  extract      => true,
  extract_path => 'C:/install/newtonsoft.json.9.0.1',
  source       => 'https://www.nuget.org/api/v2/package/Newtonsoft.Json/9.0.1',
  creates      => 'C:/install/newtonsoft.json.9.0.1/Newtonsoft.Json.nuspec',
  cleanup      => true,
}

file { 'C:/install/system.componentmodel.annotations.4.1.0':
  ensure => 'directory'
}
-> archive { 'C:/install/System.ComponentModel.Annotations.nupkg':
  ensure       => present,
  extract      => true,
  extract_path => 'C:/install/system.componentmodel.annotations.4.1.0',
  source       => 'https://www.nuget.org/api/v2/package/System.ComponentModel.Annotations/4.1.0',
  creates      => 'C:/install/system.componentmodel.annotations.4.1.0/System.ComponentModel.Annotations.nuspec',
  cleanup      => true,
}

# CONFIGURE OCTOPUS

package { 'sql-server-express':
  ensure   => installed,
  provider => chocolatey
}
-> package { 'octopusdeploy':
  ensure   => installed,
  provider => chocolatey
}
-> file { 'C:/install_octopus.bat':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    "C:\Program Files\Octopus Deploy\Octopus\Octopus.Server.exe" create-instance --instance "OctopusServer" --config "C:\Octopus\OctopusServer.config"
    "C:\Program Files\Octopus Deploy\Octopus\Octopus.Server.exe" database --instance "OctopusServer" --connectionString "Data Source=(local)\SQLEXPRESS;Initial Catalog=Octopus;Integrated Security=True" --create --grant "NT AUTHORITY\SYSTEM"
    "C:\Program Files\Octopus Deploy\Octopus\Octopus.Server.exe" configure --instance "OctopusServer" --upgradeCheck "False" --upgradeCheckWithStatistics "False" --webForceSSL "False" --webListenPrefixes "http://localhost:80/" --commsListenPort "10943" --serverNodeName "DESKTOP-JVNRAAG" --usernamePasswordIsEnabled "True"
    "C:\Program Files\Octopus Deploy\Octopus\Octopus.Server.exe" service --instance "OctopusServer" --stop
    "C:\Program Files\Octopus Deploy\Octopus\Octopus.Server.exe" admin --instance "OctopusServer" --username "admin" --email "a@a.com" --password "Password01!"
    "C:\Program Files\Octopus Deploy\Octopus\Octopus.Server.exe" service --instance "OctopusServer" --install --reconfigure --start --dependOn "MSSQL$SQLEXPRESS"
    copy /y NUL C:\OctopusDeployInstalled.txt >NUL
    | EOT
}
-> exec { 'Install Octopus':
  command => 'C:\\Windows\\system32\\cmd.exe /c C:\\install_octopus.bat',
  creates => 'C:/OctopusDeployInstalled.txt',
}
-> package { 'octopustools':
  ensure   => installed,
  provider => chocolatey
}
-> exec { 'Create Octopus Shortcut':
  provider => 'powershell',
  command  =>
    '$sh = New-Object -comObject WScript.Shell; $short = $sh.CreateShortcut($sh.SpecialFolders("Desktop") + "\\Octopus.lnk"); $short.TargetPath = "http://localhost"; $short.Save();'
}
-> file { 'C:/initialise_octopus.ps1':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    Add-Type -Path "C:/install/system.componentmodel.annotations.4.1.0/lib/netstandard1.4/System.ComponentModel.Annotations.dll"
    Add-Type -Path "C:/install/newtonsoft.json.9.0.1/lib/netstandard1.0/Newtonsoft.Json.dll"
    Add-Type -Path "C:/install/octopus.client.6.7.0/lib/netstandard2.0/Octopus.Client.dll"

    #Creating a connection
    $endpoint = new-object Octopus.Client.OctopusServerEndpoint "http://localhost"
    $repository = new-object Octopus.Client.OctopusRepository $endpoint

    #Creating login object
    $LoginObj = New-Object Octopus.Client.Model.LoginCommand
    $LoginObj.Username = "admin"
    $LoginObj.Password = "Password01!"

    #Loging in to Octopus
    $repository.Users.SignIn($LoginObj)

    #Getting current user logged in
    $UserObj = $repository.Users.GetCurrent()

    #Creating API Key for user. This automatically gets saved to the database.
    $ApiObj = $repository.Users.CreateApiKey($UserObj, "Puppet Install")

    #Save the API key so we can use it later
    Set-Content -Path c:\octopus_api.txt -Value $ApiObj.ApiKey
    | EOT
}
-> exec { 'Create API Key':
  command  => '& C:/initialise_octopus.ps1',
  provider => powershell,
}