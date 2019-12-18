class role::first_dc {
  include ::profile::base_windows
  include ::profile::base_windows_server
  include ::profile::dns::client
  include ::profile::consul::client
  include ::profile::sensu::agent_windows
  include ::profile::ad::server
}
