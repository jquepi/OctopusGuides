include apt

apt::ppa { 'ppa:openjdk-r/ppa': }
-> package { 'openjdk-13-jdk':
  ensure => installed,
}

package { 'xvfb':
  ensure => installed,
}
-> exec { 'Run xvfb':
  command   => '/usr/bin/Xvfb :99 -screen 0 1024x768x24 &',
  logoutput => true
}

package { 'firefox':
  ensure => installed,
}

file { '/opt/google-chrome-stable_current_amd64.deb':
  source => 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb',
  mode   => '0644'
}
-> package { 'Google Chrome':
  ensure   => installed,
  provider => dpkg,
  source   => '/opt/google-chrome-stable_current_amd64.deb'
}

file { '/opt/webdrivertraining-1.0-SNAPSHOT.jar':
  ensure => 'file',
  source => 'https://octopus-guides.s3.amazonaws.com/webdrivertraining-1.0-SNAPSHOT.jar'
}

# file { '/usr/bin/umoci':
#   ensure => 'file',
#   source => 'https://github.com/openSUSE/umoci/releases/download/v0.4.4/umoci.amd64',
#   mode   => '0755'
# }

archive { '/opt/geckodriver-v0.26.0-linux64.tar.gz':
  ensure       => present,
  extract      => true,
  extract_path => '/usr/bin',
  source       => 'https://github.com/mozilla/geckodriver/releases/download/v0.26.0/geckodriver-v0.26.0-linux64.tar.gz',
  creates      => '/usr/bin/geckodriver',
  cleanup      => true,
}

archive { '/opt/chromedriver_linux64.zip':
  ensure       => present,
  extract      => true,
  extract_path => '/usr/bin',
  source       => 'https://chromedriver.storage.googleapis.com/79.0.3945.16/chromedriver_linux64.zip',
  creates      => '/usr/bin/chromedriver',
  cleanup      => true,
}
-> file { '/usr/bin/chromedriver':
  owner  => 'root',
  group  => 'root',
  ensure => file,
  mode   => '0755'
}