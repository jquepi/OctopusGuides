include chocolatey

package { 'visualstudio2017buildtools':
  ensure          => installed,
  provider        => chocolatey,
  install_options => ['--package-parameters', '--add Microsoft.VisualStudio.Workload.WebBuildTools']
}

package { 'dotnetcore-sdk':
  ensure   => '2.2.402',
  provider => chocolatey,
}

download_file { 'dotnet-hosting-2.2.7-win.exe':
  destination_directory => 'C:/tools',
  url                   => 'https://octopus-guides.s3.amazonaws.com/dotnetcore/dotnet-hosting-2.2.7-win.exe',
}
-> file { 'C:/install_dotnethosting.ps1':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    Start-Process "C:\tools\dotnet-hosting-2.2.7-win.exe" -ArgumentList @("/install", "/quiet", "/norestart") -NoNewWindow -Wait
    New-Item -ItemType file c:\DotNetHostingInstalled.txt
    | EOT
}
-> exec { 'Install DotNET Hosting':
  command   => '& C:/install_dotnethosting.ps1',
  creates   => 'c:/DotNetHostingInstalled.txt',
  timeout   => 3600,
  provider  => powershell,
  logoutput => true
}

package { 'NuGet.CommandLine':
  ensure   => installed,
  provider => chocolatey
}