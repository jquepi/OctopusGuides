download_file {'bamboo.jar':
  destination_directory => 'C:/tools',
  url => 'https://octopus-guides.s3.amazonaws.com/bamboo/bamboo.jar'
}

download_file { 'sdk-installer-8.2.6.exe':
  destination_directory => 'C:/tools',
  url                   =>
    'https://octopus-guides.s3.amazonaws.com/bamboo/sdk-installer-8.2.6.exe',
}
-> file { 'C:/start_bamboo.ps1':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    ls C:\tools

    c:\tools\sdk-installer-8.2.6.exe -q -overwrite -c
    Sleep 120

    ls C:\Applications
    ls C:\Applications\Atlassian

    # Bamboo only supports java 8
    $path = Get-ChildItem "C:\Program Files\Java\" | ?{$_.Name -like "jdk1.8.0_*"} | Sort -Descending | Select -First 1 | Select -ExpandProperty FullName
    $env:JAVA_HOME=$path
    # Launch Bamboo in a background process
    start "C:\Applications\Atlassian\atlassian-plugin-sdk-8.2.6\bin\atlas-run-standalone.bat" -ArgumentList @("--product", "bamboo") -PassThru
    New-Item -ItemType file c:\BambooStarted.txt
    exit 0
    | EOT
}
-> exec { 'Start Bamboo':
  command   => '& C:/start_bamboo.ps1',
  creates   => 'C:/BambooStarted.txt',
  provider  => powershell,
  logoutput => true
}