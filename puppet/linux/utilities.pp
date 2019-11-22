include apt

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

package { 'fluxbox':
  ensure => installed,
}
-> file { '/root/.fluxbox':
  ensure => 'directory'
}
-> file { '/root/.fluxbox/init':
  ensure  => 'file',
  owner   => 'root',
  group   => 'root',
  mode    => '0755',
  content => @(EOT)
    session.screen0.toolbar.visible: false
    | EOT
}
-> package { 'xcompmgr':
  ensure => installed,
}
-> package { 'xvfb':
  ensure => installed,
}
-> exec { 'Run xvfb':
  command   => '/usr/bin/Xvfb :99 -screen 0 1920x1080x24 &',
  logoutput => true
}
-> exec { 'Run composite manager':
  command   => '/usr/bin/xcompmgr -d :99 &',
  logoutput => true
}
-> exec { 'Run fluxbox':
  command   => '/usr/bin/fluxbox &',
  logoutput => true
}

package { 'firefox':
  ensure => installed,
}

package { 'vlc':
  ensure => installed,
}

package { 'ffmpeg':
  ensure => installed,
}

package { 'awscli':
  ensure => installed,
}

file { '/opt/google-chrome-stable_current_amd64.deb':
  source => 'https://octopus-guides.s3.amazonaws.com/chrome/google-chrome-stable_current_amd64.deb',
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
  source       => 'https://chromedriver.storage.googleapis.com/78.0.3904.70/chromedriver_linux64.zip',
  creates      => '/usr/bin/chromedriver',
  cleanup      => true,
}
-> file { '/usr/bin/chromedriver':
  owner  => 'root',
  group  => 'root',
  ensure => file,
  mode   => '0755'
}