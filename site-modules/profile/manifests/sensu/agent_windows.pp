class profile::sensu::agent_windows {

  class { 'sensu::agent':
    backends    => ['mon.node.consul:8081'],
    config_hash => {
      'subscriptions' => ['windows'],
    },
  }

}
