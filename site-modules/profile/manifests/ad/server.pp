class profile::ad::server {

  dsc_user { 'Administrator':
    dsc_username    => 'Administrator',
    dsc_description => 'Administrator account',
    dsc_ensure      => 'Present',
    dsc_password    => {
       'user'     => 'Administrator',
       'password' => Sensitive(lookup('profile::ad::server::password'))
    }
  }

  file { 'C:/NTDS':
    ensure  => directory,
    require => Dsc_user['Administrator'],
  }

  dsc_windowsfeature  { 'ADDSinstall':
    dsc_ensure => 'Present',
    dsc_name   => 'AD-Domain-Services',
    require    => File['C:/NTDS'],
  }

  dsc_xaddomain { 'reskit.org':
    dsc_domainname                    => 'reskit.org',
    dsc_domainadministratorcredential => {
       'user'     => 'Administrator',
       'password' => Sensitive(lookup('profile::ad::server::password'))
    },
    dsc_safemodeadministratorpassword => {
       'user'     => 'Administrator',
       'password' => Sensitive(lookup('profile::ad::server::password'))
    },
    dsc_databasepath                  => 'c:\NTDS',
    dsc_logpath                       => 'c:\NTDS',
    subscribe                         => Dsc_windowsfeature['ADDSinstall'],
  }

  reboot {'dsc_reboot':
    message => 'DSC has requested a reboot',
    when    => pending,
  }

}
