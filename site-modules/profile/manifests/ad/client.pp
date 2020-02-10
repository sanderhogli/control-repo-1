class profile::ad::client {

   $dc_password = Sensitive(lookup('profile::ad::server::password'))

   reboot { 'dsc_reboot' :
     message => 'DSC has requested a reboot',
     when    => 'pending'
   }

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

