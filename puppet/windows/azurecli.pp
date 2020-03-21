include chocolatey

# The GitHub Action VMs come with the azure CLI, but it is an old version (as of March 2020) that
# fails to deploy web apps. So we manually update
package { 'azure-cli':
  ensure   => installed,
  provider => chocolatey,
}