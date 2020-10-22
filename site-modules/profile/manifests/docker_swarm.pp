class profile::docker_swarm {

$dir_ip = lookup( 'Address', undef, undef, '1.1.1.1' )

docker::swarm {'cluster_manager':
  init           => true,
  advertise_addr =>  $dir_ip,
  listen_addr    =>  $dir_ip ,
}
  



}