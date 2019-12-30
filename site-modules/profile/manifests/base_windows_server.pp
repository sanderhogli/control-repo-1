#  
# profile::base_windows_server
#

class profile::base_windows_server {

# use PowerShell DSC protect against wannacry :)
  dsc_windowsfeature { 'FS-SMB1': 
    dsc_ensure => 'absent', 
    dsc_name   => 'FS-SMB1', 
  }

# can't install all of RSAT, do a Get-WindowsFeature and
# create an array of the ones wanted maybe, just ADDS for now
  dsc_windowsfeature { 'ADDS':
    dsc_ensure => 'present',
    dsc_name   => 'RSAT-ADDS',
  }

}

