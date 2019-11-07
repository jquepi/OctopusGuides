file { 'C:/tools':
  ensure => 'directory'
}
-> download_file { 'vs_TeamExplorer.exe':
  destination_directory => 'C:/tools',
  url                   =>
    'https://octopus-guides.s3.amazonaws.com/azuredevops/vs_TeamExplorer.exe',
}
-> file { 'C:/install_tfcli.ps1':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    Start-Process "C:\tools\vs_TeamExplorer.exe" -ArgumentList @("install", "-q") -NoNewWindow -Wait
    New-Item -ItemType file c:\TeamExplorerInstalled.txt
    | EOT
}
-> exec { 'Install Team Explorer':
  command   => '& C:/install_tfcli.ps1',
  creates   => 'c:/TeamExplorerInstalled.txt',
  timeout   => 3600,
  provider  => powershell,
  logoutput => true
}

file { 'C:/temp':
  ensure => 'directory'
}
-> file { 'C:/populate_tfvc.ps1':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    $env:PATH += ";C:\Program Files (x86)\Microsoft Visual Studio\2017\TeamExplorer\Common7\IDE\CommonExtensions\Microsoft\TeamFoundation\Team Explorer"
    cd c:\temp
    mkdir RandomQuotesGit
    cd RandomQuotesGit
    Invoke-WebRequest -Uri https://github.com/OctopusSamples/RandomQuotes/archive/master.zip -OutFile RandomQuotes.zip
    Expand-Archive .\RandomQuotes.zip
    cd ..
    mkdir RandomQuotes
    cd RandomQuotes
    tf workspace /collection:http://localhost:9090/DefaultCollection/ /nopromt
    tf get
    cd ..
    xcopy /s RandomQuotesGit\RandomQuotes\RandomQuotes-master\*.* "RandomQuotes\Random Quotes"
    cd "RandomQuotes/Random Quotes"
    tf add * /recursive /noprompt
    tf checkin /noprompt
    New-Item -ItemType file c:\TFVCPopulated.txt
    | EOT
}
-> exec { 'Populate TFVC repo':
  command   => '& C:/populate_tfvc.ps1',
  creates   => 'c:/TFVCPopulated.txt',
  provider  => powershell,
  logoutput => true
}