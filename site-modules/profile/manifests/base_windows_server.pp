#  
# profile::base_windows_server
#

class profile::base_windows_server {

# use PowerShell DSC protect against wannacry :)
  dsc_windowsfeature {'FS-SMB1': 
    dsc_ensure => 'absent', 
    dsc_name   => 'FS-SMB1', 
  }

}

