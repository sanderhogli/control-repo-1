class role::domain_joined_server {
  include ::profile::base_windows
  include ::profile::base_windows_server
  include ::profile::dns::client
  include ::profile::consul::client
  include ::profile::sensu::agent_windows
  include ::profile::ad::client
}
