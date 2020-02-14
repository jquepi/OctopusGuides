file { '/usr/share/doc/guidescreds.txt':
  content => @("EOL"/L)
    System                                            vagrant   vagrant
    Octopus         http://localhost                  admin     Password01!
    Jenkins         http://localhost:8080             admin     Password01!
    Tomcat Manager  https://localhost:9091/manager    tomcat    Password01!
    | EOL
}

file { '/usr/share/applications/Passwords.desktop':
  content => @("EOL"/L)
    [Desktop Entry]
    Version=1.0
    Name=Passwords
    Exec=gedit /usr/share/doc/guidescreds.txt
    Terminal=false
    X-MultipleArgs=false
    Type=Application
    Icon=gedit
    Categories=Internet
    | EOL
}