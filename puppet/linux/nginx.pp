package { 'nginx':
  ensure => installed,
}
-> file_line { 'Add additional config locations':
  path    => '/etc/nginx/nginx.conf',
  line    => '    include /etc/nginx/conf.d/*/*.conf;',
  after   => '^\w+include /etc/nginx/conf.d/*.conf;',
  notify  => Service['nginx']
}
-> file_line { 'Change default port':
  path    => '/etc/nginx/sites-enabled/default',
  line    => '    listen 4444;',
  match   => '^\w*listen 80;',
  replace => true,
  notify  => Service['tomcat9']
}

service {'nginx':
  ensure => running
}