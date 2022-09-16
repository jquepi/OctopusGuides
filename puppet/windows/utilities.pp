include chocolatey

# visualstudio2019teamexplorer in chocolatey
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

# gnuwin32-coreutils.install in chocoloaty
download_file { 'coreutils-5.3.0.exe':
  destination_directory => 'C:/tools',
  url                   =>
    'https://octopus-guides.s3.amazonaws.com/coreutils/coreutils-5.3.0.exe',
}
-> exec { 'install coreutils':
  command   => 'C:/tools/coreutils-5.3.0.exe /VERYSILENT /SUPPRESSMSGBOXES /NORESTART',
  provider  => powershell,
  logoutput => true,
}

# vlc in chocoloaty
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

package { 'openjdk11':
  ensure   => installed,
  provider => chocolatey
}

package { 'openjdk17':
  ensure   => installed,
  provider => chocolatey
}

package { 'nodejs.install':
  ensure   => installed,
  provider => chocolatey
}

package { 'firefox':
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

archive { 'C:/tools/geckodriver-v0.31.0-win64.zip':
  ensure       => present,
  extract      => true,
  extract_path => 'C:/tools',
  source       => 'https://github.com/mozilla/geckodriver/releases/download/v0.31.0/geckodriver-v0.31.0-win64.zip',
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

-> archive { 'C:/tools/zulu8.46.0.19-ca-jdk8.0.252-win_x64.zip':
  ensure       => present,
  extract      => true,
  extract_path => 'C:/tools',
  source       => 'https://octopus-guides.s3.amazonaws.com/java/zulu8.46.0.19-ca-jdk8.0.252-win_x64.zip',
  creates      => 'C:/tools/zulu8.46.0.19-ca-jdk8.0.252-win_x64/release',
  cleanup      => true,
}

archive { 'C:/tools/zulu11.58.23-ca-jdk11.0.16.1-win_x64.zip':
  ensure       => present,
  extract      => true,
  extract_path => 'C:/tools',
  source       => 'https://octopus-guides.s3.amazonaws.com/java/zulu11.58.23-ca-jdk11.0.16.1-win_x64.zip',
  creates      => 'C:/tools/zulu11.58.23-ca-jdk11.0.16.1-win_x64/release',
  cleanup      => true,
}

archive { 'C:/tools/zulu17.36.17-ca-jdk17.0.4.1-win_x64.zip':
  ensure       => present,
  extract      => true,
  extract_path => 'C:/tools',
  source       => 'https://octopus-guides.s3.amazonaws.com/java/zulu17.36.17-ca-jdk17.0.4.1-win_x64.zip',
  creates      => 'C:/tools/zulu17.36.17-ca-jdk17.0.4.1-win_x64/release',
  cleanup      => true,
}