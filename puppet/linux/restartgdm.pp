# The virtualbox VMs have an issue where the start up with a black screen.
# Restarting gdm appears to fix the issue.
exec { 'Restart gdm':
  command   => '/bin/systemctl restart gdm',
  logoutput => true
}