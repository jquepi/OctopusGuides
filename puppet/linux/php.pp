file { '/opt/install_phpunit.sh':
  ensure  => 'file',
  owner   => 'root',
  group   => 'root',
  mode    => '0755',
  content => @(EOT)
    sudo wget -O /opt/phpunit https://phar.phpunit.de/phpunit-9.phar
    sudo chmod +x /opt/phpunit
    touch /opt/PHPUnitInstalled.txt
    exit 0
    | EOT
}
-> exec { 'Install PhpUnit':
  command   => '/opt/install_phpunit.sh',
  creates   => '/opt/PHPUnitInstalled.txt',
  logoutput => true
}

file { '/run/php':
  ensure => 'directory'
}
-> package { 'php-cli':
  ensure => installed,
}
-> package { 'php-fpm':
  ensure => installed,
}
-> package { 'php-mbstring':
  ensure => installed,
}
-> package { 'php-xml':
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

service {'php7.4-fpm':
  ensure => running
}

exec { 'Show status':
  command   => '/bin/systemctl status php7.4-fpm.service',
  logoutput => true
}

exec { 'Show socket file':
  command   => '/bin/ls -la /run/php',
  logoutput => true
}

exec { 'Show config':
  command   => '/bin/cat /etc/php/7.2/fpm/pool.d/www.conf',
  logoutput => true
}
