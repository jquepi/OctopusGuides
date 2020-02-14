file { '/usr/share/applications/Octopus.desktop':
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