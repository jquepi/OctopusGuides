download_file {'bamboo.jar':
  destination_directory => 'C:/tools',
  url => 'https://octopus-guides.s3.amazonaws.com/bamboo/bamboo.jar'
}

download_file { 'sdk-installer-8.2.7.exe':
  destination_directory => 'C:/tools',
  url                   =>
    'https://octopus-guides.s3.amazonaws.com/bamboo/sdk-installer-8.2.7.exe',
}
-> file { 'C:/start_bamboo.ps1':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    c:\tools\sdk-installer-8.2.7.exe -q -overwrite -c
    Sleep 60
    # Bamboo only supports java 8
    $path = Get-ChildItem "C:\Program Files\Java\" | ?{$_.Name -like "jdk1.8.0_*"} | Sort -Descending | Select -First 1 | Select -ExpandProperty FullName
    $env:JAVA_HOME=$path
    # Launch Bamboo in a background process
    start "C:\Applications\Atlassian\atlassian-plugin-sdk-8.2.7\bin\atlas-run-standalone.bat" -ArgumentList @("--product", "bamboo") -PassThru
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