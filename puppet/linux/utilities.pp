include apt

package { 'apt-transport-https':
  ensure => installed,
}

apt::ppa { 'ppa:openjdk-r/ppa': }
-> package { 'openjdk-8-jdk':
  ensure => installed,
}
-> package { 'openjdk-13-jdk':
  ensure => installed,
}
-> exec { 'Set default jdk':
  command   => '/usr/sbin/update-java-alternatives --set java-1.8.0-openjdk-amd64',
  logoutput => true
}

apt::ppa { 'ppa:mozillateam/ppa': }
-> package { 'firefox-esr':
  ensure => installed,
}

package { 'curl':
  ensure => installed,
}

package { 'jq':
  ensure => installed,
}

package { 'git':
  ensure => installed,
}


package { 'vlc':
  ensure => installed,
}

package { 'ffmpeg':
  ensure => installed,
}

package { 'awscli':
  ensure => installed
}

package { 'maven':
  ensure => installed
}

package { 'libappindicator3-1':
  ensure => installed,
}
-> package { 'fonts-liberation':
  ensure => installed,
}
-> archive { '/opt/google-chrome-stable_current_amd64.deb':
  ensure         => present,
  extract        => false,
  source         => 'https://octopus-guides.s3.amazonaws.com/chrome/google-chrome-stable_current_amd64.deb',
  allow_insecure => true,
  mode           => '0644'
}
-> package { 'Google Chrome':
  ensure   => installed,
  provider => dpkg,
  source   => '/opt/google-chrome-stable_current_amd64.deb'
}

archive { '/opt/webdrivertraining.1.0-SNAPSHOT.jar':
  ensure         => present,
  extract        => false,
  source         => 'https://octopus-guides.s3.amazonaws.com/webdrivertraining.1.0-SNAPSHOT.jar',
  allow_insecure => true,
  mode           => '0644'
}

file { '/opt/setup_13.x':
  ensure => 'file',
  source => 'https://deb.nodesource.com/setup_13.x',
  mode   => '0755'
}
-> exec { 'Install Node.js repo':
  command   => '/opt/setup_13.x',
  logoutput => true
}
-> package { 'nodejs':
  ensure => installed,
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
  source       => 'https://chromedriver.storage.googleapis.com/80.0.3987.106/chromedriver_linux64.zip',
  creates      => '/usr/bin/chromedriver',
  cleanup      => true,
}
-> file { '/usr/bin/chromedriver':
  owner  => 'root',
  group  => 'root',
  ensure => file,
  mode   => '0755'
}

