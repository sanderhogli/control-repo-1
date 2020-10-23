class profile::docker_swarm {
	class { 'docker':}


	if $hostname == 'manager' {
			docker::swarm {'cluster_manager':
			  init           => true,
			  advertise_addr =>  $ipaddress,
			  listen_addr    =>  $facts['networking']['ip'] ,
			  before => Exec[token]
			  }
			  
			exec { 'token':
				command => '/bin/echo -n  "docker_swarm::token: " >> /etc/puppetlabs/code/shared-hieradata/common.yaml',
				before => Exec[token2]
				}
			exec { 'token2':
				command => '/bin/echo  $( /usr/bin/docker swarm join-token worker | tail -2 | cut -d " " -f9) >> /etc/puppetlabs/code/shared-hieradata/common.yaml',
				}
	} else {
	
	$token = lookup('docker_swarm::token')
	
	docker::swarm {'cluster_worker':
	  join           => true,
	  advertise_addr => '192.168.1.2',
	  listen_addr    => '192.168.1.2',
	  manager_ip     => '192.168.1.1',
	  token          => '$token',
	}
	
	
	}
		
}


