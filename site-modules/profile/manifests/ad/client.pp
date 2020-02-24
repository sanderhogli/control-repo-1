class profile::ad::client {

   $dc_password = Sensitive(lookup('profile::ad::server::password'))
   $ifnames     = keys($::facts['networking']['interfaces'])
   $dc1_ip  = dns_a('dc1')[0]

   reboot { 'dsc_reboot' :
     message => 'DSC has requested a reboot',
     when    => 'pending',
     onlyif  => 'pending_dsc_reboot',
   }

   dsc_dnsserveraddress { 'DnsServerAddress':
      dsc_address        => "$dc1_ip",
      dsc_interfacealias => "${ifnames[0]}",
      dsc_addressfamily  => 'IPv4',
   } ->
   dsc_computer { 'JoinDomain':
     dsc_name       => "${facts['hostname']}",
     dsc_domainname => 'reskit.org',
     dsc_credential => {
       'user'     => 'RESKIT\\Administrator',
       'password' => $dc_password
       },
     notify         => Reboot['dsc_reboot'],
   }
 
}

