node.set['postgresql']['enable_pgdg_apt'] = true
node.set['postgresql']['version'] = '9.4'

# On server systems, the postgres server is restarted when a configuration
# file changes. This can be changed to reload only by setting the following
# attribute:
node.set['postgresql']['server']['config_change_notify'] = :reload

node.set[:postgresql][:config][:listen_addresses] = "localhost"
node.set[:postgresql][:config][:port] = 5432
node.set[:postgresql][:config][:max_connections] = 100

default_hba = [
  {:type => 'local', :db => 'all', :user => 'all', :addr => nil, :method => 'trust'},
  {:type => 'host', :db => 'all', :user => 'all', :addr => '127.0.0.1/32', :method => 'trust'},
  {:type => 'host', :db => 'all', :user => 'all', :addr => '::1/128', :method => 'trust'}
]
node.set[:postgresql][:pg_hba] = default_hba

node.set[:sysctl][:attributes][:kernel][:shm_max] = '2147483648'

## Additional tuning for production
if node[:production]
  node.set[:postgresql][:config][:shared_buffers] = '1GB'
  node.set[:postgresql][:config][:max_connections] = 500
  node.set[:postgresql][:config][:effective_cache_size] = '3GB'
  node.set[:postgresql][:config][:effective_io_concurrency] = 2
  node.set[:postgresql][:config][:checkpoint_segments] = 12
end


include_recipe "postgresql"
include_recipe "postgresql::server"

