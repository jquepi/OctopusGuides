package { 'nginx':
  ensure => installed,
}
# -> file_line { 'Add additional config locations':
#   path    => '/etc/nginx/nginx.conf',
#   line    => '    include /etc/nginx/conf.d/*/*.conf;',
#   after   => '^\s*include /etc/nginx/conf.d/*.conf;',
#   notify  => Service['nginx']
# }
-> file_line { 'Change default ipv4 port':
  path    => '/etc/nginx/sites-enabled/default',
  line    => '    listen 4444 default_server;',
  match   => '^\s*listen 80 default_server;',
  replace => true,
  notify  => Service['nginx']
}
-> file_line { 'Change default ipv6 port':
  path    => '/etc/nginx/sites-enabled/default',
  line    => '    listen [::]:4444 default_server;',
  match   => '^\s*listen \[::\]:80 default_server;',
  replace => true,
  notify  => Service['nginx']
}

service {'nginx':
  ensure => running
}