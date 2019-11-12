include apt

apt::ppa { 'ppa:openjdk-r/ppa': }
-> package { 'openjdk-13':
  ensure => installed,
}

package { 'xvfb':
  ensure => installed,
}
-> exec { 'Run xvfb':
  command   => '/usr/bin/Xvfb :99 -screen 0 1024x768x24 &',
  logoutput => true
}

file { '/opt/webdrivertraining-1.0-SNAPSHOT.jar':
  ensure => 'file',
  source => 'https://octopus-guides.s3.amazonaws.com/webdrivertraining-1.0-SNAPSHOT.jar'
}

archive { '/opt/geckodriver-v0.26.0-linux64.tar.gz':
  ensure       => present,
  extract      => true,
  extract_path => '/usr/bin',
  source       => 'https://github.com/mozilla/geckodriver/releases/download/v0.26.0/geckodriver-v0.26.0-linux64.tar.gz',
  creates      => '/usr/bin/geckodriver',
  cleanup      => true,
}