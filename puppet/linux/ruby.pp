package { 'ruby':
  ensure => 'latest'
}
-> package { 'ruby-dev':
  ensure => 'latest'
}
-> exec { 'Install gems':
  command   => '/usr/bin/gem install --no-document rspec sinatra unicorn bundler',
  logoutput => true
}

