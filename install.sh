wget https://apt.puppetlabs.com/puppet6-release-bionic.deb
sudo dpkg -i puppet6-release-bionic.deb
sudo apt-get update
sudo apt-get install puppet-agent

sudo /opt/puppetlabs/bin/puppet module install puppetlabs/apt

for var in "$@"
do
    sudo /opt/puppetlabs/bin/puppet apply puppet/linux/$var
done
