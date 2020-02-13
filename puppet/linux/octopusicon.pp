file { '/etc/skel':
  ensure => 'directory'
}
-> file { '/etc/skel/Desktop':
  ensure => 'directory'
}
-> file { '/etc/skel/Desktop/Octopus.desktop':
  content => @("EOL"/L)
    [Desktop Entry]
    Version=1.0
    Name=Octopus Deploy
    Comment=Username: admin Password: Password01!
    Exec=firefox http://localhost
    Terminal=false
    X-MultipleArgs=false
    Type=Application
    Icon=firefox
    Categories=Internet
    | EOL
}