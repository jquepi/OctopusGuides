package { 'ruby':
  ensure => 'latest'
}
-> package { 'ruby-dev':
  ensure => 'latest'
}
-> package { 'rspec':
  ensure   => 'latest',
  provider => 'gem',
  install_options   => ['--no-document', '--no-ri']
}
-> package { 'sinatra':
  ensure   => 'latest',
  provider => 'gem',
  install_options   => ['--no-document', '--no-ri']
}
-> package { 'unicorn':
  ensure   => 'latest',
  provider => 'gem',
  install_options   => ['--no-document', '--no-ri']
}
-> package { 'bundler':
  ensure   => 'latest',
  provider => 'gem',
  install_options   => ['--no-document', '--no-ri']
}

