download_file {'bamboo.jar':
  destination_directory => 'C:/tools',
  url => 'https://octopus-guides.s3.amazonaws.com/bamboo/bamboo.jar'
}

file { 'C:/atlas':
  ensure => 'directory'
}
-> archive { 'C:/tools/atlassian-plugin-sdk-8.2.7.zip':
  ensure       => present,
  extract      => true,
  extract_path => 'C:/atlas',
  source       => 'https://octopus-guides.s3.amazonaws.com/bamboo/atlassian-plugin-sdk-8.2.7.zip',
  creates      => 'C:/atlas/installtype.txt',
  cleanup      => true,
}
-> file { 'C:/start_bamboo.ps1':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    ls c:\atlas

    # Bamboo only supports java 8
    $path = Get-ChildItem "C:\Program Files\Java\" | ?{$_.Name -like "jdk1.8.0_*"} | Sort -Descending | Select -First 1 | Select -ExpandProperty FullName
    $env:JAVA_HOME=$path
    # Launch Bamboo in a background process
    start "c:\atlas\bin\atlas-run-standalone.bat" -ArgumentList @("--product", "bamboo") -PassThru
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