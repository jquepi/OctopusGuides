# Due to a bug with the video drivers in Virtualbox, a black screen is displayed on startup.
# See https://www.virtualbox.org/ticket/19496 for details.
# Resizing the window fixes the issue. So we create a startup application that runs xrandr
# to trigger a resize.
file { '/home/vagrant/.config':
  ensure => 'directory',
  owner  => 'vagrant',
  group  => 'vagrant'
}
-> file { '/home/vagrant/.config/autostart':
  ensure => 'directory',
  owner  => 'vagrant',
  group  => 'vagrant'
}
-> file { '/home/vagrant/.config/autostart/resize.desktop':
  owner   => 'vagrant',
  group   => 'vagrant',
  content => @("EOL"/L)
    [Desktop Entry]
    Type=Application
    Name=Resize Desktop
    Exec=xrandr --size 1360x768
    Terminal=false
    X-GNOME-Autostart-enabled=true
    | EOL
}