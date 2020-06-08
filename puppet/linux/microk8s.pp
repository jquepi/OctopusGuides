apt::key { 'kubernetes-repository':
  id     => '54A647F9048D5688D7DA2ABE6A030B21BA07F4FB',
  source => 'https://packages.cloud.google.com/apt/doc/apt-key.gpg',
  server  => 'pgp.mit.edu'
}
-> apt::source { 'kubernetes':
  comment  => 'This is the kubernetes repository',
  location => 'http://apt.kubernetes.io/',
  release  => '',
  repos    => 'kubernetes-xenial main',
  key      => {
    'id' => '54A647F9048D5688D7DA2ABE6A030B21BA07F4FB',
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
-> package { 'iptables-persistent':
  ensure => installed,
}
-> exec { 'Install MicroK8s':
  command   => '/usr/bin/snap install microk8s --classic',
  logoutput => true
}
-> exec { 'Extract cert':
  command   => '/snap/bin/microk8s.kubectl config view --raw -o json | jq -r \'.clusters[0].cluster."certificate-authority-data"\' | tr -d \'"\' | base64 --decode > /tmp/ca.crt',
  logoutput => true
}
-> exec { 'Enable DNS':
  command   => '/snap/bin/microk8s.enable dns',
  logoutput => true
}
-> exec { 'Enable iptables forwarding':
  command   => '/sbin/iptables -P FORWARD ACCEPT',
  logoutput => true
}
# see https://github.com/ubuntu/microk8s/issues/1150
-> file { '/opt/fix-microk8s-certs.sh':
  ensure  => 'file',
  owner   => 'root',
  group   => 'root',
  mode    => '0755',
  content => @(EOT)
#!/bin/bash

set -eu

export SNAP_NAME="microk8s"
export SNAP_DATA="/var/snap/microk8s/current/"
export SNAP="/snap/microk8s/current/"

export PATH="$SNAP/usr/sbin:$SNAP/usr/bin:$SNAP/sbin:$SNAP/bin:$PATH"
source $SNAP/actions/common/utils.sh

if [ -e ${SNAP_DATA}/var/lock/clustered.lock ]
then
  echo "This MicroK8s deployment is acting as a node in a cluster. Please use the microk8s refresh-cert command on the master"
  echo "and then return to this node to perform a microk8s leave and re-join."
  exit 0
fi

if echo "$*" | grep -v -q -- '--kubeconfig'; then
  exit_if_no_permissions
fi

# Backup
BACKUP=$SNAP_DATA/var/log/ca-backup/
echo "Backing up certificates under $BACKUP"
mkdir -p $SNAP_DATA/var/log/ca-backup/
cp -r ${SNAP_DATA}/certs $BACKUP
cp -r ${SNAP_DATA}/credentials $BACKUP/

echo "Creating new certificates"
rm -rf ${SNAP_DATA}/certs/ca.crt
rm -rf ${SNAP_DATA}/certs/front-proxy-ca.crt
rm -rf ${SNAP_DATA}/certs/csr.conf
produce_certs
rm -rf .srl

# Create the basic tokens
echo "Creating new kubeconfig file"
mkdir -p ${SNAP_DATA}/credentials
admin_token=`grep admin ${SNAP_DATA}/credentials/basic_auth.csv | cut -d, -f1`
ca_data=$(cat ${SNAP_DATA}/certs/ca.crt | ${SNAP}/usr/bin/base64 -w 0)

# Create the client kubeconfig
cp ${SNAP}/client.config.template ${SNAP_DATA}/credentials/client.config
$SNAP/bin/sed -i 's/PASSWORD/'"${admin_token}"'/g' ${SNAP_DATA}/credentials/client.config
$SNAP/bin/sed -i 's/CADATA/'"${ca_data}"'/g' ${SNAP_DATA}/credentials/client.config
$SNAP/bin/sed -i 's/NAME/admin/g' ${SNAP_DATA}/credentials/client.config
$SNAP/bin/sed -i 's/AUTHTYPE/password/g' ${SNAP_DATA}/credentials/client.config
$SNAP/bin/sed -i 's/PASSWORD/'"${admin_token}"'/g' ${SNAP_DATA}/credentials/client.config

# Create the known tokens
proxy_token=`grep kube-proxy ${SNAP_DATA}/credentials/known_tokens.csv | cut -d, -f1`
hostname=$(hostname)
kubelet_token=`grep kubelet-0 ${SNAP_DATA}/credentials/known_tokens.csv | cut -d, -f1`
controller_token=`grep kube-controller-manager ${SNAP_DATA}/credentials/known_tokens.csv | cut -d, -f1`
scheduler_token=`grep kube-scheduler ${SNAP_DATA}/credentials/known_tokens.csv | cut -d, -f1`

# Create the client kubeconfig for the controller
cp ${SNAP}/client.config.template ${SNAP_DATA}/credentials/controller.config
$SNAP/bin/sed -i 's/CADATA/'"${ca_data}"'/g' ${SNAP_DATA}/credentials/controller.config
$SNAP/bin/sed -i 's/NAME/controller/g' ${SNAP_DATA}/credentials/controller.config
$SNAP/bin/sed -i '/username/d' ${SNAP_DATA}/credentials/controller.config
$SNAP/bin/sed -i 's/AUTHTYPE/token/g' ${SNAP_DATA}/credentials/controller.config
$SNAP/bin/sed -i 's/PASSWORD/'"${controller_token}"'/g' ${SNAP_DATA}/credentials/controller.config

# Create the client kubeconfig for the scheduler
cp ${SNAP}/client.config.template ${SNAP_DATA}/credentials/scheduler.config
$SNAP/bin/sed -i 's/CADATA/'"${ca_data}"'/g' ${SNAP_DATA}/credentials/scheduler.config
$SNAP/bin/sed -i 's/NAME/scheduler/g' ${SNAP_DATA}/credentials/scheduler.config
$SNAP/bin/sed -i '/username/d' ${SNAP_DATA}/credentials/scheduler.config
$SNAP/bin/sed -i 's/AUTHTYPE/token/g' ${SNAP_DATA}/credentials/scheduler.config
$SNAP/bin/sed -i 's/PASSWORD/'"${scheduler_token}"'/g' ${SNAP_DATA}/credentials/scheduler.config

# Create the proxy and kubelet kubeconfig
cp ${SNAP}/client.config.template ${SNAP_DATA}/credentials/kubelet.config
$SNAP/bin/sed -i 's/NAME/kubelet/g' ${SNAP_DATA}/credentials/kubelet.config
$SNAP/bin/sed -i 's/CADATA/'"${ca_data}"'/g' ${SNAP_DATA}/credentials/kubelet.config
$SNAP/bin/sed -i '/username/d' ${SNAP_DATA}/credentials/kubelet.config
$SNAP/bin/sed -i 's/AUTHTYPE/token/g' ${SNAP_DATA}/credentials/kubelet.config
$SNAP/bin/sed -i 's/PASSWORD/'"${kubelet_token}"'/g' ${SNAP_DATA}/credentials/kubelet.config

cp ${SNAP}/client.config.template ${SNAP_DATA}/credentials/proxy.config
$SNAP/bin/sed -i 's/NAME/kubeproxy/g' ${SNAP_DATA}/credentials/proxy.config
$SNAP/bin/sed -i 's/CADATA/'"${ca_data}"'/g' ${SNAP_DATA}/credentials/proxy.config
$SNAP/bin/sed -i '/username/d' ${SNAP_DATA}/credentials/proxy.config
$SNAP/bin/sed -i 's/AUTHTYPE/token/g' ${SNAP_DATA}/credentials/proxy.config
$SNAP/bin/sed -i 's/PASSWORD/'"${proxy_token}"'/g' ${SNAP_DATA}/credentials/proxy.config

echo "Restarting microK8s"
$SNAP/microk8s-stop.wrapper || true
$SNAP/microk8s-start.wrapper
    | EOT
}
-> exec { 'Fix certs':
  command   => '/opt/fix-microk8s-certs.sh',
  logoutput => true
}
