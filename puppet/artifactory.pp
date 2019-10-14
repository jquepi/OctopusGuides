archive { 'C:/install/jfrog-artifactory-oss-6.13.1.zip':
  ensure       => present,
  extract      => true,
  extract_path => 'C:/install',
  source       => 'https://octopus-guides.s3.amazonaws.com/artifactory/jfrog-artifactory-oss-6.13.1.zip',
  creates      => 'C:/install/artifactory-oss-6.13.1/README.txt',
  cleanup      => true,
}
-> file { 'C:/install_artifactory.ps1':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    start "C:\install\artifactory-oss-6.13.1\bin\artifactory.bat" -PassThru
    New-Item -ItemType file c:\ArtifactoryStarted.txt
    | EOT
}
-> exec { 'Install Artifactory':
  command  => '& C:/install_artifactory.ps',
  creates  => 'c:/ArtifactoryStarted.txt',
  timeout  => 3600,
  provider => powershell,
}