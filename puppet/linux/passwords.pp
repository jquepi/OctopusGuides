file { '/usr/share/doc/guidescreds.txt':
  content => @("EOL"/L)
    Credentials
    ===========

    Note: Not all VMs have all the applications listed below installed. Use the icons on the
    launcher to open the services available on your VM.

    See https://app.vagrantup.com/octopusdeploy for other Vagrant boxes with different
    configurations.

    System                                            vagrant   vagrant
    Octopus          http://localhost                  admin     Password01!
    Jenkins          http://localhost:8080             admin     Password01!
    Tomcat Manager   https://localhost:9091/manager    tomcat    Password01!
    WildFly Manager  https://localhost:9990/manager    admin     Password01!

    Useful Commands
    ===============

    microk8s.kubectl get pods --all-namespaces
    For VMs with Kubernetes installed, this lists all the pods deployed to microk8s.

    docker logs -f octopusdeploy
    Octopus is deployed as a Docker container, and this command will tail the log output.

    sudo systemctl restart docker-octopusdeploy
    The Octopus Docker container is managed as a systemd service, and can be controlled with systemctl.
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