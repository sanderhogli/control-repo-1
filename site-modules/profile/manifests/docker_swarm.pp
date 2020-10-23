class profile::docker_swarm {
	class { 'docker':}

$token = lookup('docker_swarm::token')

	if $hostname == 'manager' {
			docker::swarm {'cluster_manager':
			  init           => true,
			  advertise_addr =>  $ipaddress,
			  listen_addr    =>  $facts['networking']['ip'] ,
			  before => Exec[token]
			  }
			  
			exec { 'token':
				command => '/bin/echo -n "docker_swarm::token:" >> /etc/puppetlabs/code/shared-hieradata/common.yaml',
				#path    => '/usr/local/bin/:/bin/',
				# path    => [ '/usr/local/bin/', '/bin/' ],  # alternative synt  
				}
			exec { 'token2':
				command => '/bin/echo  $(/usr/bin/docker swarm join-token worker | cut -d "," -f 3 ) >> /etc/puppetlabs/code/shared-hieradata/common.yaml',
				#     => '/usr/local/bin/:/bin/',
				# path    => [ '/usr/local/bin/', '/usr/bin/docker' ],  # alternative synt
				}
			  
	} else {
	
	docker::swarm {'cluster_worker':
	  join           => true,
	  advertise_addr => '192.168.1.2',
	  listen_addr    => '192.168.1.2',
	  manager_ip     => '192.168.1.1',
	  token          => '$token',
	}
	
	
	}
		
}


