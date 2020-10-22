class profile::docker_swarm {

docker::swarm {'cluster_manager':
  init           => true,
  advertise_addr =>  [ $::serverip ],
  listen_addr    =>  [ $::serverip ],
}
  



}