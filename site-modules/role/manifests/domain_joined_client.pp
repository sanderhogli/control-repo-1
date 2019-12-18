class role::domain_joined_client {
  include ::profile::base_windows
  include ::profile::dns::client
  include ::profile::consul::client
  include ::profile::sensu::agent_windows
  include ::profile::ad::client
}
