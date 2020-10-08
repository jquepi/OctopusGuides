archive { '/opt/packages-microsoft-prod.deb':
  ensure         => present,
  extract        => false,
  source         => 'https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb',
  allow_insecure => true
}
-> package { 'atlassian-plugin-sdk':
  provider => dpkg,
  ensure   => installed,
  source   => "/opt/packages-microsoft-prod.deb"
}
-> exec { 'Update apt repo 1':
  command   => '/usr/bin/apt-get update',
  logoutput => false
}
-> exec { 'Update apt repo 3':
  command   => '/usr/bin/add-apt-repository universe',
  logoutput => false
}
-> package { 'powershell':
  ensure => installed,
}