package { 'nginx':
  ensure => installed,
}
-> file_line { 'Add additional config locations':
  path    => '/etc/nginx/nginx.conf',
  line    => '    include /etc/nginx/conf.d/*/*.conf',
  after   => '^\w+include /etc/nginx/conf.d/*.conf',
  notify  => Service['nginx']
}