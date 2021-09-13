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
-> archive { 'C:/tools/nssm-2.24.zip':
  ensure       => present,
  extract      => true,
  extract_path => 'C:/tools',
  source       => 'https://octopus-guides.s3.amazonaws.com/bamboo/nssm-2.24.zip',
  creates      => 'C:/tools/nssm-2.24/win64/nssm.exe',
  cleanup      => true,
}
-> archive { 'C:/tools/zulu8.46.0.19-ca-jdk8.0.252-win_x64.zip':
  ensure       => present,
  extract      => true,
  extract_path => 'C:/',
  source       => 'https://octopus-guides.s3.amazonaws.com/java/zulu8.46.0.19-ca-jdk8.0.252-win_x64.zip',
  creates      => 'C:/zulu8.46.0.19-ca-jdk8.0.252-win_x64/release',
  cleanup      => true,
}
-> file { 'C:/start_bamboo.ps1':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    # Bamboo only supports java 8, and only versions lower than 255
    # Caused by: java.lang.IllegalArgumentException: Invalid version number: Version number may be negative or greater than 255
    #    at com.ibm.icu.util.VersionInfo.getInstance(VersionInfo.java:191)
    # See https://stackoverflow.com/questions/64040255/invalid-version-number-version-number-may-be-negative-or-greater-than-255

    # Launch Bamboo in a service
    c:\tools\nssm-2.24\win64\nssm.exe install Bamboo "C:\atlas\bin\atlas-run-standalone.bat"
    c:\tools\nssm-2.24\win64\nssm.exe set Bamboo AppDirectory C:\
    c:\tools\nssm-2.24\win64\nssm.exe set Bamboo AppParameters --product bamboo
    c:\tools\nssm-2.24\win64\nssm.exe set Bamboo AppEnvironmentExtra JAVA_HOME=C:\zulu8.46.0.19-ca-jdk8.0.252-win_x64
    c:\tools\nssm-2.24\win64\nssm.exe set Bamboo AppStdout C:\bamboo.out
    c:\tools\nssm-2.24\win64\nssm.exe set Bamboo AppStderr C:\bamboo.out
    net start Bamboo

    sleep 120

    Get-Content C:\bamboo.out
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