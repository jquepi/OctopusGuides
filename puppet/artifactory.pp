package { 'NuGet.CommandLine':
  ensure   => installed,
  provider => chocolatey
}
-> archive { 'C:/install/jfrog-artifactory-oss-6.13.1.zip':
  ensure       => present,
  extract      => true,
  extract_path => 'C:/install',
  source       => 'https://octopus-guides.s3.amazonaws.com/artifactory/jfrog-artifactory-pro-6.13.1.zip',
  creates      => 'C:/install/artifactory-pro-6.13.1/README.txt',
  cleanup      => true,
}
-> file_line { 'installStateName':
  path    => 'C:/install/artifactory-pro-6.13.1/tomcat/conf/server.xml',
  line    => '        <Connector port="8041" sendReasonPhrase="true" relaxedPathChars=\'[]\' relaxedQueryChars=\'[]\' maxThreads="200"/>',
  match   => '^\s*<Connector port="8081" sendReasonPhrase="true" relaxedPathChars=\'\[\]\' relaxedQueryChars=\'\[\]\' maxThreads="200"/>',
  replace => true,
}
-> file { 'C:/install_artifactory.ps1':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    start "C:\install\artifactory-pro-6.13.1\bin\artifactory.bat" -PassThru
    C:\ProgramData\chocolatey\bin\nuget.exe sources add -Name Artifactory -Source http://localhost:8041/artifactory/api/nuget/NuGet -Username admin -Password password
    New-Item -ItemType file c:\ArtifactoryStarted.txt
    | EOT
}
-> exec { 'Install Artifactory':
  command  => '& C:/install_artifactory.ps1',
  creates  => 'c:/ArtifactoryStarted.txt',
  timeout  => 3600,
  provider => powershell,
}