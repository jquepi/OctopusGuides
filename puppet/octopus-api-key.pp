file { 'C:/initialise_octopus.ps1':
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
  command   => '& C:/initialise_octopus.ps1',
  creates   => 'C:/octopus_api.txt',
  provider  => powershell,
  logoutput => true
}