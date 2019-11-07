package { 'visualstudio2019teamexplorer':
  ensure   => installed,
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

    # Extract the RandomQuotes ZIP file sourced from GitHub
    cd c:\temp
    mkdir RandomQuotesGit
    cd RandomQuotesGit
    Invoke-WebRequest -Uri https://github.com/OctopusSamples/RandomQuotes/archive/master.zip -OutFile RandomQuotes.zip
    Expand-Archive .\RandomQuotes.zip
    cd ..

    # Create a workspace that links to the Azure Devops TFVC repo
    mkdir RandomQuotes
    cd RandomQuotes
    tf workspace /new /collection:http://localhost:9090/DefaultCollection/ /noprompt
    tf get
    cd ..

    # Copy the files from GitHub into the workspace
    xcopy /s RandomQuotesGit\RandomQuotes\RandomQuotes-master\*.* "RandomQuotes\Random Quotes"
    cd "RandomQuotes/Random Quotes"

    # Add the new files and check them in
    tf add * /recursive /noprompt
    tf checkin /noprompt

    # A marker file for puppet
    New-Item -ItemType file c:\TFVCPopulated.txt
    | EOT
}
-> exec { 'Populate TFVC repo':
  command   => '& C:/populate_tfvc.ps1',
  creates   => 'c:/TFVCPopulated.txt',
  provider  => powershell,
  logoutput => true
}