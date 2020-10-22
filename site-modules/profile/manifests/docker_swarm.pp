class profile::docker_swarm {

$dir_ip = lookup( 'Address', undef, undef, '1.1.1.1' )

class { 'docker':}

docker::swarm {'cluster_manager':
  init           => true,
  advertise_addr =>  $ipaddress,
  listen_addr    =>  $facts['networking']['ip'] ,
}
  



}