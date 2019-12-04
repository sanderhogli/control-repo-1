class profile::consul::client {

  case $facts['os']['name'] {
    'windows': {

      class { '::consul':
        version     => '1.6.2',
        config_hash => {
          'datacenter'       => 'NTNU',
          'log_level'        => 'INFO',
          'node_name'        => $facts['hostname'],
          'retry_join'       => [ $::serverip ],
        },
      }

    }

    /^(Debian|Ubuntu)$/: { 

      package { 'unzip':
        ensure => latest,
      }

      class { '::consul':
        version     => '1.6.2',
        config_hash => {
          'data_dir'         => '/opt/consul',
          'datacenter'       => 'NTNU',
          'log_level'        => 'INFO',
          'node_name'        => $facts['hostname'],
          'retry_join'       => [ $::serverip ],
        },
        require     => Package['unzip'],
      }

    }

    default: { notify { 'Which OS? WTF???': } }

  }

}

