package { 'ruby':
  ensure => 'latest'
}
-> package { 'ruby-dev':
  ensure => 'latest'
}
-> package { 'rspec':
  ensure   => 'latest',
  provider => 'gem',
  source   => 'https://rubygems.org'
}
-> package { 'sinatra':
  ensure   => 'latest',
  provider => 'gem',
  source   => 'https://rubygems.org'
}
-> package { 'unicorn':
  ensure   => 'latest',
  provider => 'gem',
  source   => 'https://rubygems.org'
}
-> package { 'bundler':
  ensure   => 'latest',
  provider => 'gem',
  source   => 'https://rubygems.org'
}

