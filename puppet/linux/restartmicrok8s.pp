# Microk8s has a habit of being unresponsive after a deployment in Hyperv, so we restart it
# between deployments.
exec { 'Stop microk8s':
  command => '/snap/bin/microk8s.stop',
  logoutput => true
}
-> exec { 'Start microk8s':
  command => '/snap/bin/microk8s.start',
  logoutput => true
}