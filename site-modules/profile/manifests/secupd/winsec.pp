# puppet configuration for automatic security updates in Windows
# using the dsc module

class profile::secupd::winsec {
  #Configures the xWindowsUpdateAgent
  dsc_xwindowsupdateagent {'MuSecurityImportant':
    dsc_issingleinstance => yes,
    dsc_category         => ['Security', 'Important'],
    dsc_updatenow        => true,
    dsc_notifications    => 'ScheduledInstallation',
    dsc_source           => 'WindowsUpdate',
  }
  #Configures registry values for windows update
  dsc_registry {'AUOptions':
    dsc_ensure    => 'present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate\AU',
    dsc_valuename => 'AUOptions',
    dsc_valuedata => '4',
    dsc_valuetype => 'Dword',
  }

  dsc_registry {'ScheduledInstallDay':
    dsc_ensure    => 'present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate\AU',
    dsc_valuename => 'ScheduledInstallDay',
    dsc_valuedata => '0',
    dsc_valuetype => 'Dword',
  }

  dsc_registry {'ScheduledInstallTime':
    dsc_ensure    => 'present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate\AU',
    dsc_valuename => 'ScheduledInstallTime',
    dsc_valuedata => '2',
    dsc_valuetype => 'Dword',
  }

}
