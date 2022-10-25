include apt

package { 'webp':
  ensure => installed,
}

package { 'apt-transport-https':
  ensure => installed,
}

# Bamboo does not support Java 11
package { 'openjdk-11-jdk':
  ensure => 'absent',
}

apt::ppa { 'ppa:openjdk-r/ppa': }
-> package { 'openjdk-8-jdk':
  ensure => installed,
}
-> exec { 'Set default jdk':
  command   => '/usr/sbin/update-java-alternatives --set java-1.8.0-openjdk-amd64',
  logoutput => true
}

archive { '/opt/openjdk-17.0.1_linux-x64_bin.tar.gz':
  ensure          => present,
  extract         => true,
  extract_path    => '/opt',
  source          => 'https://octopus-guides.s3.amazonaws.com/java/openjdk-17.0.1_linux-x64_bin.tar.gz',
  creates         => '/opt/jdk-17.0.1/release',
  cleanup         => true,
  extract_command => 'tar xfz %s'
}

apt::ppa {
  'ppa:mozillateam/ppa':

}
#-> package { 'firefox':
#  ensure => installed,
#}
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

package { 'net-tools':
  ensure => installed
}

# Fixes this error:
# gpg: requesting key from 'https://apt.octopus.com/public.key'
# gpg: connecting dirmngr at '/tmp/apt-key-gpghome.IXhzaPEb24/S.dirmngr' failed: IPC connect call failed
# gpg: WARNING: unable to fetch URI https://apt.octopus.com/public.key: No dirmngr
package { 'dirmngr':
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
  source         => 'https://octopus-guides.s3.amazonaws.com/chrome/google-chrome-stable_current_amd64.deb'
}
-> package { 'Google Chrome':
  ensure   => installed,
  provider => dpkg,
  source   => '/opt/google-chrome-stable_current_amd64.deb'
}

archive { '/opt/webdrivertraining.1.0-SNAPSHOT.jar':
  ensure         => present,
  extract        => false,
  source         => 'https://octopus-guides.s3.amazonaws.com/webdrivertraining.1.0-SNAPSHOT.jar'
}

archive { '/opt/setup_14.x':
  ensure         => present,
  extract        => false,
  source         => 'https://deb.nodesource.com/setup_14.x'
}
-> file { '/opt/setup_14.x':
  ensure => 'file',
  mode   => '0755'
}
-> exec { 'Install Node.js repo':
  command   => '/opt/setup_14.x',
  logoutput => true
}
-> package { 'nodejs':
  ensure => installed,
}

archive { '/opt/geckodriver-v0.31.1-linux32.tar.gz':
  ensure       => present,
  extract      => true,
  extract_path => '/usr/bin',
  source       => 'https://github.com/mozilla/geckodriver/releases/download/v0.31.0/geckodriver-v0.31.0-linux64.tar.gz',
  creates      => '/usr/bin/geckodriver',
  cleanup      => true,
}

archive { '/opt/chromedriver_linux64.zip':
  ensure       => present,
  extract      => true,
  extract_path => '/usr/bin',
  source       => 'https://chromedriver.storage.googleapis.com/105.0.5195.52/chromedriver_linux64.zip',
  creates      => '/usr/bin/chromedriver',
  cleanup      => true,
}
-> file { '/usr/bin/chromedriver':
  owner  => 'root',
  group  => 'root',
  ensure => file,
  mode   => '0755'
}
