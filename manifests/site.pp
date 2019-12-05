node default {
  notify { "Oops Default! I'm ${facts['hostname']}": }
}
node 'winsrv0.node.consul' {
  include ::profile::base_windows
  include ::profile::dns::client
  include ::profile::consul::client
  include ::profile::sensu::agent_windows
  include ::profile::ad::server
}
node /winsrv\d?.node.consul/ {
  include ::profile::base_windows
  include ::profile::dns::client
  include ::profile::consul::client
  include ::profile::sensu::agent_windows
}
node /wincl\d?.node.consul/ {
  include ::profile::base_windows
  include ::profile::dns::client
  include ::profile::consul::client
  include ::profile::sensu::agent_windows
}
node 'manager.node.consul' {
  include ::profile::base_linux
  include ::profile::dns::client
  include ::profile::consul::server
}
node 'dir.node.consul' {
  include ::role::directory_server
}
node 'mon.node.consul' {
  include ::role::monitoring_server
}
