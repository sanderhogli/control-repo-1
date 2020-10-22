class profile::docker_swarm {

$dir_ip = lookup( 'Address', undef, undef, '1.1.1.1' )

docker::swarm {'cluster_manager':
  init           => true,
  advertise_addr =>  $ipaddres,
  listen_addr    =>  $facts['networking']['primary'] ,
}
  



}