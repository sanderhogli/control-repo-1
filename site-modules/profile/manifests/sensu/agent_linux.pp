class profile::sensu::agent_linux {

  class { 'sensu::agent':
    backends    => ['mon.node.consul:8081'],
    config_hash => {
      'subscriptions' => ['linux'],
    },
  }

}
