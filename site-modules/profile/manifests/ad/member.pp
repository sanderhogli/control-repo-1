class profile::ad::member {

   $dc_password = Sensitive(lookup('profile::ad::server::password'))
   $ifnames     = keys($::facts['networking']['interfaces'])
   $winsrv0_ip  = dns_a('winsrv0')[0]

   reboot { 'dsc_reboot' :
     message => 'DSC has requested a reboot',
     when    => 'pending'
   }

   dsc_dnsserveraddress { 'DnsServerAddress':
      dsc_address        => "$winsrv0_ip",
      dsc_interfacealias => "${ifnames[0]}",
      dsc_addressfamily  => 'IPv4',
   } ->
   dsc_user { 'Administrator':
     dsc_username    => 'Administrator',
     dsc_description => 'Administrator account',
     dsc_ensure      => 'Present',
     dsc_password    => {
        'user'     => 'Administrator',
        'password' => $dc_password
     }
   } ->
   dsc_computer { 'JoinDomain':
     dsc_name       => "${facts['hostname']}",
     dsc_domainname => 'borg.trek',
     dsc_credential => {
       'user'     => 'BORG\\Administrator',
       'password' => $dc_password
       },
     notify         => Reboot['dsc_reboot'],
   } ->
   dsc_windowsfeature { 'ADDSInstall':
     dsc_ensure => 'present',
     dsc_name   => 'AD-Domain-Services',
   } ->
   dsc_xwaitforaddomain { 'DscForestWait':
     dsc_domainname           => 'borg.trek',
     dsc_domainusercredential => {
       'user'     => 'BORG\\Administrator',
       'password' => $dc_password
       },
     dsc_retrycount           => 20,
     dsc_retryintervalsec     => 30,
   } ->
   dsc_xaddomaincontroller { 'ReplicaDC':
     dsc_domainname                     => 'borg.trek',
     dsc_domainadministratorcredential  => {
       'user'     => 'BORG\\Administrator',
       'password' => $dc_password
       },
     dsc_safemodeadministratorpassword  => {
       'user'     => 'BORG\\Administrator',
       'password' => $dc_password
       },
     notify                             => Reboot['dsc_reboot'],
   }
}

