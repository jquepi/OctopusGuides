file { '/etc/skel':
  ensure => 'directory'
}
-> file { '/etc/skel/Desktop':
  ensure => 'directory'
}
-> file { '/etc/skel/Desktop/Jenkins.desktop':
  content => @("EOL"/L)
    [Desktop Entry]
    Version=1.0
    Name=Jenkins
    Comment=Username: admin Password: Password01!
    Exec=firefox http://localhost:8080
    Terminal=false
    X-MultipleArgs=false
    Type=Application
    Icon=firefox
    Categories=Internet
    | EOL
}