class profile::ad::server {

  file { 'C:/NTDS':
    ensure => directory,
  }
 
  dsc_windowsfeature  { 'ADDSinstall':
    dsc_ensure => 'Present',
    dsc_name   => 'AD-Domain-Services',
    require    => File['C:/NTDS'],
  }
 
  dsc_xaddomain { 'borg.trek':
    dsc_domainname                    => 'borg.trek',
    dsc_domainadministratorcredential => {
               'user'     => 'data',
               'password' => Sensitive(lookup('profile::ad::server::password'))
    },
    dsc_safemodeadministratorpassword => {
       'user'     => 'data',
       'password' => Sensitive(lookup('profile::ad::server::password'))
    },
    dsc_databasepath                  => 'c:\NTDS',
    dsc_logpath                       => 'c:\NTDS',
    subscribe                         => Dsc_windowsfeature['addsinstall'],
  }
 
  reboot {'dsc_reboot':
    message => 'DSC has requested a reboot',
    when    => pending,
  }

}
