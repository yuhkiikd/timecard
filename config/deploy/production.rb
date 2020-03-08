server '52.196.156.153', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/vagrant/.ssh/id_rsa'