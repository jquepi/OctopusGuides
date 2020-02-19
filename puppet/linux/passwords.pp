file { '/usr/share/doc/guidescreds.txt':
  content => @("EOL"/L)
    Credentials
    ===========

    System                                            vagrant   vagrant
    Octopus         http://localhost                  admin     Password01!
    Jenkins         http://localhost:8080             admin     Password01!
    Tomcat Manager  https://localhost:9091/manager    tomcat    Password01!

    Useful Commands
    ===============

    sudo -H minikube ip
    This IP is where the Kubernetes deployments can be accessed (e.g. http://172.29.74.77:30001).

    kubectl get pods --all-namespaces
    This lists all the pods deployed to minikube.

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