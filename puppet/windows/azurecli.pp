include chocolatey

# The GitHub Action VMs come with the azure CLI, but it is an old version (as of March 2020) that
# fails to deploy web apps. So we manually update. Note 2.30.0 had issues installing.
//package { 'azure-cli':
//  ensure   => '2.29.2',
//  provider => chocolatey,
//}