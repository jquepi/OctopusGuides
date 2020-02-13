file { '/etc/skel':
  ensure => 'directory'
}
-> file { '/etc/skel/Desktop':
  ensure => 'directory'
}
-> file { '/etc/skel/Desktop/Tomcat.desktop':
  content => @("EOL"/L)
    [Desktop Entry]
    Version=1.0
    Name=Tomcat
    Comment=Username: tomcat Password: Password01!
    Exec=firefox http://localhost:9091/manager
    Terminal=false
    X-MultipleArgs=false
    Type=Application
    Icon=firefox
    Categories=Internet
    | EOL
}