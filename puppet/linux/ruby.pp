package { 'ruby':
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
