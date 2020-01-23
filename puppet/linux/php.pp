package { 'php-cli':
  ensure => installed,
}
-> package { 'php-fpm':
  ensure => installed,
}
-> package { 'php-mbstring':
  ensure => installed,
}
-> file { '/opt/install_composer.sh':
  ensure  => 'file',
  owner   => 'root',
  group   => 'root',
  mode    => '0755',
  content => @(EOT)
    sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
    touch /opt/ComposerInstalled.txt
    exit 0
    | EOT
}
-> exec { 'Install Composer':
  command   => '/opt/install_composer.sh',
  creates   => '/opt/ComposerInstalled.txt',
  logoutput => true
}

service {'php-fpm':
  ensure => running
}
-> exec { 'Show socket file':
  command   => '/bin/ls -la /run/php',
  logoutput => true
}-> exec { 'Show config':
  command   => '/bin/cat /etc/php/7.2/fpm/pool.d/www.conf',
  logoutput => true
}