package { 'php-fpm':
  ensure => installed,
}
-> file { '/opt/install_composer.sh':
  ensure  => 'file',
  owner   => 'root',
  group   => 'root',
  mode    => '0755',
  content => @(EOT)
    sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    touch /opt/ComposerInstalled.txt
    exit 0
    | EOT
}
-> exec { 'Install Composer':
  command   => '/opt/install_composer.sh',
  creates   => '/opt/ComposerInstalled.txt',
  logoutput => true
}