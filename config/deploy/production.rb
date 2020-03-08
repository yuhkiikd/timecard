server '52.196.156.153', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/User/vagrant/.ssh/id_rsa'