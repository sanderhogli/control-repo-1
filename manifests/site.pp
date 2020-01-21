node default {
  notify { "Oops Default! I'm ${facts['hostname']}": }
}

node /dc1/ {
  include ::role::first_dc
}

node /dc2/ {
  include ::role::domain_joined_server
}

node /srv[1-9]?/ {
  include ::role::domain_joined_server
}

node /cl\d?/ {
  include ::role::domain_joined_client
}

node 'manager.node.consul' {
  include ::role::manager_server
}

node 'dir.node.consul' {
  include ::role::directory_server
}

node 'mon.node.consul' {
  include ::role::monitoring_server
}
