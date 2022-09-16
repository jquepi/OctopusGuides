apt::key { 'kubernetes-repository':
  id     => '59FE0256827269DC81578F928B57C5C2836F4BEB',
  source => 'https://packages.cloud.google.com/apt/doc/apt-key.gpg',
  server  => 'pgp.mit.edu'
}
-> apt::source { 'kubernetes':
  comment  => 'This is the kubernetes repository',
  location => 'http://apt.kubernetes.io/',
  release  => '',
  repos    => 'kubernetes-xenial main',
  key      => {
    'id' => '59FE0256827269DC81578F928B57C5C2836F4BEB',
  },
  include  => {
    'deb' => true,
  },
}
-> package { 'kubectl':
  ensure => installed,
}
-> package { 'openssl':
  ensure => installed,
}
-> package { 'conntrack':
  ensure => installed,
}
-> archive { '/usr/local/bin/minikube':
  ensure         => present,
  extract        => false,
  source         => 'https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64'
}
-> file { '/usr/local/bin/minikube':
  mode   => '0755'
}
-> file { '/opt/start-minikube.sh':
  ensure  => 'file',
  mode    => '0744',
  content => @(EOT)
    #!/bin/bash
    # The GitHub Actions VM has a custom Docker version like 3.0.8, and minikube doesn't understand this version,
    # so we ignore the system verification errors
    # Also see https://stackoverflow.com/questions/65397050/minikube-does-not-start-on-ubuntu-20-04-lts-exiting-due-to-guest-provision
    # for how to fix the error "Exiting due to NOT_FOUND_CRI_DOCKERD:"

    su runner -c "minikube start --driver=docker --extra-config=kubeadm.ignore-preflight-errors=SystemVerification"
    cat /home/runner/.kube/config
    su runner -c "kubectl get nodes"

    # Create a pfx file with the client certificate and key
    openssl pkcs12 -passout pass: -export -out /tmp/client.pfx -in /home/runner/.minikube/profiles/minikube/client.crt -inkey /home/runner/.minikube/profiles/minikube/client.key
    cp /home/runner/.minikube/ca.crt /tmp/ca.crt
    chmod 644 /tmp/ca.crt
    chmod 644 /tmp/client.pfx
    chmod 644 /home/runner/.minikube/profiles/minikube/client.crt
    chmod 644 /home/runner/.minikube/profiles/minikube/client.key
    chmod 644 /home/runner/.minikube/ca.crt
    echo "Listing /tmp"
    ls -la /tmp
    echo "Listing /home/runner/.minikube"
    ls -la /home/runner/.minikube

    # Show some details
    echo "Minikube IP"
    su runner -c "minikube ip > /tmp/minikubeip.txt"
    cat /tmp/minikubeip.txt

    # Describe the nodes
    su runner -c "kubectl describe nodes"

    # fix the coredns pods crashing
    # https://github.com/kubernetes/kubeadm/issues/998#issuecomment-412099190
    su runner -c "kubectl -n kube-system get deployment coredns -o yaml | sed 's/allowPrivilegeEscalation: false/allowPrivilegeEscalation: true/g' | kubectl apply -f -"

    touch /opt/minikube-started
    | EOT
}
-> exec { 'Start minikube':
  command   => '/opt/start-minikube.sh',
  creates   => '/opt/minikube-started',
  timeout   => 3600,
  logoutput => true
}
