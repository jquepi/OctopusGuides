package { 'ruby':
  ensure => 'latest'
}
-> package { 'ruby-dev':
  ensure => 'latest'
}
-> package { 'rspec':
  ensure   => 'latest',
  provider => 'gem',
  install_options   => ['--no-document']
}
-> package { 'sinatra':
  ensure   => 'latest',
  provider => 'gem',
  install_options   => ['--no-document']
}
-> package { 'unicorn':
  ensure   => 'latest',
  provider => 'gem',
  install_options   => ['--no-document']
}
-> package { 'bundler':
  ensure   => 'latest',
  provider => 'gem',
  install_options   => ['--no-document']
}

