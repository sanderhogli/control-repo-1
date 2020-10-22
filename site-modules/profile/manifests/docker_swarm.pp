class profile::docker_swarm {

class {'docker_swarm':}

swarm_cluster {'cluster 1':
    ensure       => present,
    backend      => 'consul',
    cluster_type => 'manage',
    port         => '8500',
    address      => '[ $::serverip ]',
    advertise    => $::ipaddress_enp0s8,
    path         => 'swarm',
    }
  }



}