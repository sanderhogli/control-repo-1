class profile::wordpress { 

	class {'docker::compose':
	  ensure => present,
	}

	file { '/tmp/docker-compose.yml':
		ensure  => present,
		content => "
		compose_test:
			image: ubuntu:14.04
			command: /bin/sh -c "while true; do echo hello world; sleep 1; done"
		"
	}
	
	docker_compose { 'test':
		compose_files => ['/tmp/docker-compose.yml'],
		ensure  => present,
	}
	
}
