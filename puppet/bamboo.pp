download_file { 'sdk-installer-8.0.16.exe':
  destination_directory => 'C:/tools',
  url                   =>
    'https://octopus-guides.s3.amazonaws.com/bamboo/sdk-installer-8.0.16.exe',
}
-> file { 'C:/start_bamboo.ps1':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    c:\tools\sdk-installer-8.0.16.exe -q -overwrite -c
    Sleep 60
    New-Item -ItemType Directory -Path C:\bamboo\target\classes -Force
    # We fake extension development with an boilerplate pom.xml file and an empty atlassian-plugin.xml file. This means
    # we get to run atlas-run to get a development version of Bamboo up and running.
    cp config/pom.xml c:\bamboo
    cp config/atlassian-plugin.xml C:\bamboo\target\classes
    cd c:\bamboo
    # Bamboo only supports java 8
    $path = Get-ChildItem "C:\Program Files\Java\" | ?{$_.Name -like "jdk1.8.0_*"} | Sort -Descending | Select -First 1 | Select -ExpandProperty FullName
    $env:JAVA_HOME=$path
    # Launch Bamboo in a background process
    start "C:\Applications\Atlassian\atlassian-plugin-sdk-8.0.16\bin\atlas-run.bat" -PassThru
    New-Item -ItemType file c:\BambooStarted.txt
    exit 0
    | EOT
}
-> exec { 'Start Bamboo':
  command  => '& C:/start_bamboo.ps1',
  creates => 'C:/BambooStarted.txt',
  provider => powershell,
}