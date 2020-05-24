package { 'visualstudio2019teamexplorer':
  ensure   => '16.4.5.0',
  provider => chocolatey
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
    # This is the path where the tf.exe file is found
    $env:PATH += ";C:\Program Files (x86)\Microsoft Visual Studio\2019\TeamExplorer\Common7\IDE\CommonExtensions\Microsoft\TeamFoundation\Team Explorer"

    Write-Host "Extract the RandomQuotes ZIP file sourced from GitHub"
    cd c:\temp
    mkdir RandomQuotesGit
    cd RandomQuotesGit
    Invoke-WebRequest -Uri https://github.com/OctopusSamples/RandomQuotes-aspmvc4/archive/master.zip -OutFile RandomQuotes.zip
    Expand-Archive .\RandomQuotes.zip
    cd ..

    Write-Host "Create a workspace that links to the Azure Devops TFVC repo"
    mkdir RandomQuotes
    cd RandomQuotes
    tf workspace /new /collection:http://localhost:9090/DefaultCollection/ /noprompt
    tf get
    cd ..

    Write-Host "Copy the files from GitHub into the workspace"
    xcopy /s /Y RandomQuotesGit\RandomQuotes\RandomQuotes-aspmvc4-master\*.* "RandomQuotes\Random Quotes"
    cd "RandomQuotes/Random Quotes"

    Write-Host "Add the new files and check them in"
    tf add * /recursive /noprompt
    tf checkin /noprompt

    Write-Host "Create a marker file for puppet"
    New-Item -ItemType file c:\TFVCPopulated.txt
    | EOT
}
-> exec { 'Populate TFVC repo':
  command   => '& C:/populate_tfvc.ps1',
  creates   => 'c:/TFVCPopulated.txt',
  provider  => powershell,
  logoutput => true
}