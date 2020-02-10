class profile::dns::client {

  $dc1_ip = dns_a('dc1.node.consul')[0]
  $dir_ip = lookup( 'Address', undef, undef, '1.1.1.1' )

  case $facts['os']['name'] {
    'windows': {
      dsc_dnsserveraddress { 'DnsServerAddress':
        dsc_address        => $dc1_ip,
        dsc_interfacealias => $facts['networking']['primary'],
        dsc_addressfamily  => 'IPv4',
      }
      dsc_dnsclientglobalsetting { 'domainname':
        dsc_issingleinstance => yes,
        dsc_suffixsearchlist => ['reskit.org','node.consul'],
      }
    }
    /^(Debian|Ubuntu)$/: { 
      class { 'netplan':
        config_file   => '/etc/netplan/50-cloud-init.yaml',
        ethernets     => {
          'ens3' => {
            'dhcp4'       => true,
            'nameservers' => {
              'search'    => ['node.consul'],
              'addresses' => [ "$dir_ip" ],
            }
          }
        },
        netplan_apply => true,
      }
    }
    default: { notify { 'Which OS? WTF???': } }
  }

}

