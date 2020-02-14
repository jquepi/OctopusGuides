file { '/usr/share/applications/Tomcat.desktop':
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

file { '/usr/share/applications/Random Quotes Dev.desktop':
  content => @("EOL"/L)
    [Desktop Entry]
    Version=1.0
    Name=Random Quotes Dev
    Exec=firefox http://localhost:9091/randomquotes-dev
    Terminal=false
    X-MultipleArgs=false
    Type=Application
    Icon=firefox
    Categories=Internet
    | EOL
}

file { '/usr/share/applications/Random Quotes Test.desktop':
  content => @("EOL"/L)
    [Desktop Entry]
    Version=1.0
    Name=Random Quotes Test
    Exec=firefox http://localhost:9091/randomquotes-test
    Terminal=false
    X-MultipleArgs=false
    Type=Application
    Icon=firefox
    Categories=Internet
    | EOL
}