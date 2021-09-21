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
# Skip the initial wizard, and set the admin credentials. Also disable CSRF as it has caused issues in the past.
-> file_line { 'jenkins args':
  path    => 'C:/Jenkins/jenkins.xml',
  line    =>
    '  <arguments>-Xrs -Xmx256m -Dhudson.security.csrf.GlobalCrumbIssuerConfiguration.DISABLE_CSRF_PROTECTION=true -Djenkins.install.runSetupWizard=false -Dhudson.lifecycle=hudson.lifecycle.WindowsServiceLifecycle -jar "C:\Jenkins\jenkins.war" --httpPort=8080 --webroot="%LocalAppData%\Jenkins\war" --argumentsRealm.passwd.admin=Password01! --argumentsRealm.roles.admin=admin</arguments>'
  ,
  match   => '^\s*<arguments>.+?</arguments>',
  replace => true
}
# Change the home directory, as MSBuild doesn't work well with paths like "C:\Windows\System32\config\systemprofile\AppData\Local\Jenkins\.jenkins"
# Otherwise you get errors like "MSBUILD : error MSB1009: Project file does not exist"
-> file_line { 'jenkins home':
  path    => 'C:/Jenkins/jenkins.xml',
  line    =>
    '  <env name="JENKINS_HOME" value="C:\JenkinsHome"/>'
  ,
  match   => '^\s*<env name="JENKINS_HOME".+?/>',
  replace => true
}
-> exec { 'Restart Jenkins with new home dir':
  command   => 'C:\\Windows\\system32\\cmd.exe /c net stop Jenkins & net start Jenkins',
  logoutput => true
}