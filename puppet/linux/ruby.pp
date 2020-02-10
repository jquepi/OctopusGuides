exec { 'Install rvm keys':
  command   => '/usr/bin/gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB',
  logoutput => true
}
-> exec { 'Install rvm':
  command   => '/usr/bin/curl -sSL https://get.rvm.io | bash -s stable',
  logoutput => true
}
-> exec { 'Install ruby':
  command   => '/usr/local/rvm/bin/rvm install ruby-2.6.3',
  logoutput => true
}
-> exec { 'Default ruby':
  command   => '/usr/local/rvm/bin/rvm alias create default ruby-2.6.3',
  logoutput => true
}