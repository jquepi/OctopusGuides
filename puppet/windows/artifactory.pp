file { 'C:/tools':
    ensure => 'directory'
}
-> file { 'C:/tools/pstools':
    ensure => 'directory'
}-> archive { 'C:/tools/PSTools.zip':
    ensure       => present,
    extract      => true,
    extract_path => 'C:/tools/pstools',
    source       => 'https://download.sysinternals.com/files/PSTools.zip',
    creates      => 'C:/tools/pstools/PsExec.exe',
    cleanup      => true,
}

package { 'NuGet.CommandLine':
  ensure   => installed,
  provider => chocolatey
}
-> archive { 'C:/install/jfrog-artifactory-pro-6.17.0.zip':
  ensure       => present,
  extract      => true,
  extract_path => 'C:/install',
  source       => 'https://octopus-guides.s3.amazonaws.com/artifactory/jfrog-artifactory-pro-6.17.0.zip',
  creates      => 'C:/install/artifactory-pro-6.17.0/README.txt',
  cleanup      => true,
}
# Change the repo port to 8041 to avoid a conflict with the IIS ports that have been used to deploy apps
-> file_line { 'Artifactory Port Settings':
  path    => 'C:/install/artifactory-pro-6.17.0/tomcat/conf/server.xml',
  line    =>
    '        <Connector port="8041" sendReasonPhrase="true" relaxedPathChars=\'[]\' relaxedQueryChars=\'[]\' maxThreads="200"/>'
  ,
  match   =>
    '^\s*<Connector port="8081" sendReasonPhrase="true" relaxedPathChars=\'\[\]\' relaxedQueryChars=\'\[\]\' maxThreads="200"/>'
  ,
  replace => true,
}
# Reduce the memory that Artifactory can consume
-> file_line { 'Artifactory Memory Settings':
  path    => 'C:/install/artifactory-pro-6.17.0/bin/artifactory.bat',
  line    => 'set JAVA_OPTIONS=-server -Xms384m -Xmx384m -Xss256k -XX:+UseG1GC',
  match   => 'set JAVA_OPTIONS=-server -Xms512m -Xmx4g -Xss256k -XX:\+UseG1GC',
  replace => true,
}
# -> file { 'C:/install_artifactory.ps1':
#   ensure  => 'file',
#   owner   => 'Administrators',
#   group   => 'Administrators',
#   mode    => '0644',
#   content => @(EOT)
#     start "C:\install\artifactory-pro-6.17.0\bin\artifactory.bat" -PassThru
#     # Add the NuGet source for the current user
#     C:\ProgramData\chocolatey\bin\nuget.exe sources add `
#       -Name Artifactory `
#       -Source http://localhost:8041/artifactory/api/nuget/NuGet `
#       -Username admin `
#       -Password Password01!
#     # Add the NuGet source for the LOCAL SYSTEM user
#     C:\tools\pstools\PsExec.exe `
#       -s C:\ProgramData\chocolatey\bin\nuget.exe sources add `
#       -Name Artifactory `
#       -Source http://localhost:8041/artifactory/api/nuget/NuGet `
#       -Username admin `
#       -Password Password01!
#     New-Item -ItemType file c:\ArtifactoryStarted.txt
#     | EOT
# }
# -> exec { 'Install Artifactory':
#   command   => '& C:/install_artifactory.ps1',
#   creates   => 'c:/ArtifactoryStarted.txt',
#   timeout   => 3600,
#   provider  => powershell,
#   logoutput => true
# }