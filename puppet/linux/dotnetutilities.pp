file { '/opt/packages-microsoft-prod.deb':
  source => 'https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb',
  mode   => '0644'
}
-> package { 'packages-microsoft-prod':
  ensure   => installed,
  provider => dpkg,
  source   => '/opt/packages-microsoft-prod.deb'
}
-> exec { 'Update apt repo':
  command   => '/usr/bin/apt-get update',
  logoutput => false
}
-> package { 'apt-transport-https':
  ensure => installed,
}
-> package { 'dotnet-sdk-3.0':
  ensure => installed,
}
-> package { 'dotnet-runtime-2.2':
  ensure => installed,
}