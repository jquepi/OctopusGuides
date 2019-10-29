include chocolatey

package { 'gnuwin32-coreutils.install':
  ensure   => installed,
  provider => chocolatey
}

package { 'sysinternals':
  ensure   => installed,
  provider => chocolatey
}

package { 'vlc':
  ensure   => installed,
  provider => chocolatey
}

package { 'ffmpeg':
  ensure   => installed,
  provider => chocolatey
}

package { 'NuGet.CommandLine':
  ensure   => installed,
  provider => chocolatey
}

package { '7zip':
  ensure   => installed,
  provider => chocolatey
}

package { 'git':
  ensure   => installed,
  provider => chocolatey
}

package { 'notepadplusplus':
  ensure   => installed,
  provider => chocolatey
}

package { 'terraform':
  ensure   => installed,
  provider => chocolatey
}

package { 'jdk8':
  ensure   => installed,
  provider => chocolatey
}

package { 'openjdk13':
  ensure   => installed,
  provider => chocolatey
}

package { 'firefox':
  ensure   => "69.0.3",
  provider => chocolatey
}

package { 'visualstudio2017buildtools':
  ensure          => installed,
  provider        => chocolatey,
  install_options => ['--package-parameters', '--add Microsoft.VisualStudio.Workload.WebBuildTools']
}

package { 'dotnetcore-sdk':
  ensure   => '2.2.402',
  provider => chocolatey,
}

package { 'kubernetes-helm':
  ensure   => installed,
  provider => chocolatey
}

package { 'kubernetes-cli':
  ensure   => installed,
  provider => chocolatey
}

package { 'awscli':
  ensure   => installed,
  provider => chocolatey
}

file { 'C:/screenshots':
  ensure => 'directory'
}

windows_env { 'PATH=C:\tools': }

file { 'C:/tools':
  ensure => 'directory'
}

archive { 'C:/tools/ungoogled-chromium-77.0.3865.75-1_windows.7z':
  ensure       => present,
  extract      => true,
  extract_path => 'C:/tools',
  source       =>
    'https://github.com/macchrome/winchrome/releases/download/v77.0.3865.75-r681094-Win64/ungoogled-chromium-77.0.3865.75-1_windows.7z'
  ,
  creates      => 'C:/tools/ungoogled-chromium-77.0.3865.75-1_windows/chrome.exe',
  cleanup      => true,
}

archive { 'C:/tools/chromedriver_win32.zip':
  ensure       => present,
  extract      => true,
  extract_path => 'C:/tools',
  source       => 'https://chromedriver.storage.googleapis.com/77.0.3865.40/chromedriver_win32.zip',
  creates      => 'C:/tools/chromedriver.exe',
  cleanup      => true,
}

archive { 'C:/tools/geckodriver-v0.26.0-win64.zip':
  ensure       => present,
  extract      => true,
  extract_path => 'C:/tools',
  source       => 'https://github.com/mozilla/geckodriver/releases/download/v0.26.0/geckodriver-v0.26.0-win64.zip',
  creates      => 'C:/tools/geckodriver.exe',
  cleanup      => true,
}

download_file { 'webdrivertraining-1.0-SNAPSHOT.jar':
  destination_directory => 'C:/tools',
  url                   => 'https://octopus-guides.s3.amazonaws.com/webdrivertraining-1.0-SNAPSHOT.jar',
}

download_file { 'dotnet-hosting-2.2.7-win.exe':
  destination_directory => 'C:/tools',
  url                   => 'https://octopus-guides.s3.amazonaws.com/dotnetcore/dotnet-hosting-2.2.7-win.exe',
}
-> file { 'C:/install_dotnethosting.ps1':
  ensure  => 'file',
  owner   => 'Administrators',
  group   => 'Administrators',
  mode    => '0644',
  content => @(EOT)
    Start-Process "C:\tools\dotnet-hosting-2.2.7-win.exe" -ArgumentList @("/install", "/quiet", "/norestart") -NoNewWindow -Wait
    New-Item -ItemType file c:\DotNetHostingInstalled.txt
    | EOT
}
-> exec { 'Install Azure':
  command   => '& C:/install_dotnethosting.ps1',
  creates   => 'c:/DotNetHostingInstalled.txt',
  timeout   => 3600,
  provider  => powershell,
  logoutput => true
}

file { 'C:/install':
  ensure => 'directory'
}