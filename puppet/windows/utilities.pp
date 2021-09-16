include chocolatey

# Team explorer tools started to fail to install via chocolatey
/*package { 'visualstudio2019teamexplorer':
  ensure   => installed,
  provider => chocolatey
}*/

archive { 'C:/tools/vs_TeamExplorer.zip':
  ensure       => present,
  extract      => true,
  extract_path => 'C:/tools',
  source       => 'https://octopus-guides.s3.amazonaws.com/visualstudio/vs_TeamExplorer.zip',
  creates      => 'C:/tools/vs_TeamExplorer/vs_setup.exe',
  cleanup      => true,
}
# https://silentinstallhq.com/visual-studio-team-explorer-2019-silent-install-how-to-guide/
-> exec { 'Install VS Team Explorer tools':
  command   => 'C:/tools/vs_TeamExplorer/vs_setup.exe --nocache --wait --noUpdateInstaller --noWeb --allWorkloads --includeRecommended --includeOptional --quiet --norestart',
  provider  => powershell,
  logoutput => true,
}


package { 'gnuwin32-coreutils.install':
  ensure   => installed,
  provider => chocolatey
}

# VLC started to fail to install via chocolatey
/*package { 'vlc':
  ensure   => installed,
  provider => chocolatey
}*/

archive { 'C:/tools/vlc-3.0.16-win32.zip':
  ensure       => present,
  extract      => true,
  extract_path => 'C:/tools',
  source       => 'https://octopus-guides.s3.amazonaws.com/vlc/vlc-3.0.16-win32.zip',
  creates      => 'C:/tools/vlc-3.0.16/vlc.exe',
  cleanup      => true,
}

package { 'ffmpeg':
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

package { 'jdk8':
  ensure   => installed,
  provider => chocolatey
}

package { 'openjdk':
  ensure   => installed,
  provider => chocolatey
}

package { 'nodejs.install':
  ensure   => installed,
  provider => chocolatey
}

package { 'firefoxesr':
  ensure   => installed,
  provider => chocolatey
}

package { 'awscli':
  ensure   => installed,
  provider => chocolatey,
  # On 03 March 2020 the checksums were failing, so force the install anyway
  install_options => ['--ignore-checksums']
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

archive { 'C:/tools/geckodriver-v0.27.0-win64.zip':
  ensure       => present,
  extract      => true,
  extract_path => 'C:/tools',
  source       => 'https://github.com/mozilla/geckodriver/releases/download/v0.27.0/geckodriver-v0.27.0-win64.zip',
  creates      => 'C:/tools/geckodriver.exe',
  cleanup      => true,
}

download_file { 'webdrivertraining.1.0-SNAPSHOT.jar':
  destination_directory => 'C:/tools',
  url                   => 'https://octopus-guides.s3.amazonaws.com/webdrivertraining.1.0-SNAPSHOT.jar',
}

file { 'C:/install':
  ensure => 'directory'
}