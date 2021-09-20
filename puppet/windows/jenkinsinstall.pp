# Install this early, as it takes a few minutes to initilaize
# Jenkins in chocolaty hasn't been updated in quite a while, so manually install

download_file {'jenkins.msi':
  destination_directory => 'C:/tools',
  url => 'https://octopus-guides.s3.amazonaws.com/jenkins/jenkins.msi'
}
-> file { 'C:/start_jenkins.ps1':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    start-process msiexec -Wait -ArgumentList @("JENKINSDIR=C:\Jenkins", "/qn", "/norestart", "/l*v", "c:\jenkinsinstall.log", "/i", "c:\tools\jenkins.msi")
    Get-Content c:\jenkinsinstall.log
    net start jenkins
    New-Item -ItemType file c:\JenkinsStarted.txt
    exit 0
    | EOT
}
-> exec { 'Start Jenkins':
  command   => '& C:/start_jenkins.ps1',
  creates   => 'C:/JenkinsStarted.txt',
  provider  => powershell,
  logoutput => true
}