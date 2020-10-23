class profile::docker_swarm {
class {'docker_swarm':}

swarm_cluster {'cluster 1':
  ensure       => present,
  backend      => 'swarm',
  cluster_type => 'create',
  } 
		
}


