download_file { 'azuredevopsexpress2019.exe':
  destination_directory => 'C:/tools',
  url                   =>
    'https://octopus-guides.s3.amazonaws.com/azuredevops/azuredevopsexpress2019.exe',
}
-> exec { 'Install Azure Devops':
  provider => 'powershell',
  command => '& "C:\\tools\\azuredevopsexpress2019.exe" /silent '
}
-> exec { 'Deploy Azure Devops':
  provider => 'powershell',
  command => '& "C:\\Program Files\\Azure DevOps Server 2019\\Tools\\TfsConfig" unattend /unattendfile:.\\config\\azuredevops.ini /continue'
}