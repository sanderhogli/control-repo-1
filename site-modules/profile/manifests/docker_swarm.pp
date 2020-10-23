class profile::docker_swarm {
	class { 'docker':}


	if $hostname == 'manager' {
			docker::swarm {'cluster_manager':
			  init           => true,
			  advertise_addr =>  $ipaddress,
			  listen_addr    =>  $facts['networking']['ip'] ,
			}
	} else {
	
	docker::swarm {'cluster_worker':
	  join           => true,
	  advertise_addr => '192.168.1.2',
	  listen_addr    => '192.168.1.2',
	  manager_ip     => '192.168.1.1',
	  token          => '$facts[docker_worker_join_token]',
	}
	
	
	}
		
}


