class profile::ad::client {

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
   dsc_computer { 'JoinDomain':
     dsc_name       => "${facts['hostname']}",
     dsc_domainname => 'borg.trek',
     dsc_credential => {
       'user'     => 'BORG\\Administrator',
       'password' => $dc_password
       },
     notify         => Reboot['dsc_reboot'],
   }
 
}

