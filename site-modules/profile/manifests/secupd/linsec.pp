# puppet configuration for automatic security updates in linux, 
# using the unattended-upgrades module

class profile::secupd::linsec {

  $reboot_time = lookup('secupd::linsec::reboot_time')

  include apt

  #netplan needs to be latest, or else Unattended-upgrades wont run properly. We do not know the cause for this
  package { 'netplan.io':
    ensure => latest,
  }
  #configures unattended-upgrades
  -> class { 'unattended_upgrades':
    package_ensure => latest,
    auto           => { 'reboot'      => false,
                        'reboot_time' => $reboot_time,
                        'clean'       => 7,
    },

    update         => 1,
    upgrade        => 1,
  }
}
