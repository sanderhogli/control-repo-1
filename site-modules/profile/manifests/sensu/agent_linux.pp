class profile::sensu::agent_linux {

  class { 'sensu::agent':
    backends    => ['mon.node.consul:8081'],
    config_hash => {
      'subscriptions' => ['linux'],
    },
  }

  class { 'sensu::plugins':
    plugins => {
      'disk-checks' => { 'version' => '5.0.0' },
      'cpu-checks'  => { 'version' => '4.0.0' },
    },
  }

}
