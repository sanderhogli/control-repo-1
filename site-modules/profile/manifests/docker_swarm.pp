class profile::docker_swarm {


	class { 'docker':}

		docker::swarm {'cluster_manager':
		  init           => true,
		  advertise_addr =>  $ipaddress,
		  listen_addr    =>  $facts['networking']['ip'] ,
		}
}


