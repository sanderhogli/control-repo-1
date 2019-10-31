class profile::sensu::agent_linux {

  class { 'sensu::agent':
    backends    => ['mon.node.consul:8081'],
    config_hash => {
      'subscriptions' => ['linux'],
    },
  }
  sensu_check { 'check-cpu':
    ensure        => 'present',
    command       => 'check-cpu.sh -w 75 -c 90',
    interval      => 60,
    subscriptions => ['linux'],
  }
  class { 'sensu::plugins':
    plugins => {
      'disk-checks' => { 'version' => 'latest' },
    },
  }

}
