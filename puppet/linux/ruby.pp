package { 'ruby':
  ensure => installed,
}
-> package { 'ruby-dev':
  ensure => installed,
}
-> package { 'sinatra':
  ensure => installed,
  provider => 'gem',
}
-> package { 'unicorn':
  ensure => installed,
  provider => 'gem',
}
-> package { 'bundler':
  ensure => installed,
  provider => 'gem',
}

