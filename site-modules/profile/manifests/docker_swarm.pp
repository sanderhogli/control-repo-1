class profile::docker_swarm {

docker::swarm {'cluster_manager':
  init           => true,
  advertise_addr =>  'manager.node.consul',
  listen_addr    =>  'manager.node.consul' ,
}
  



}