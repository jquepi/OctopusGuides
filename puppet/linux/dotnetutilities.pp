package { 'packages-microsoft-prod':
  ensure   => installed,
  provider => dpkg,
  source => 'https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb'
}
-> package { 'apt-transport-https':
  ensure => installed,
}
-> package { 'dotnet-sdk-3.0':
  ensure => installed,
}