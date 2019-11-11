wget https://apt.puppetlabs.com/puppet6-release-bionic.deb
sudo dpkg -i puppet6-release-bionic.deb
sudo apt-get install puppet-agent

sudo puppet module install module puppetlabs/apt