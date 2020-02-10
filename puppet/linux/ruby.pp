package { 'ruby':
  ensure => 'latest'
}
-> package { 'ruby-dev':
  ensure => 'latest'
}
-> exec { 'Install gems':
  command   => '/usr/bin/gem install --no-document rspec sinatra unicorn bundler:2.1.4 rack',
  logoutput => true
}
-> exec { 'Install rvm keys':
  command   => '/usr/bin/gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB',
  logoutput => true
}
-> exec { 'Install rvm':
  command   => '/usr/bin/curl -sSL https://get.rvm.io | bash -s stable',
  logoutput => true
}

