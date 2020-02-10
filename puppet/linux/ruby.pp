package { 'ruby':
  ensure => 'latest'
}
-> package { 'ruby-dev':
  ensure => 'latest'
}
-> package { 'rspec':
  ensure => 'latest',
  provider => 'gem'
}
-> package { 'sinatra':
  ensure => 'latest',
  provider => 'gem'
}
-> package { 'unicorn':
  ensure => 'latest',
  provider => 'gem'
}
-> package { 'bundler':
  ensure => 'latest',
  provider => 'gem'
}

