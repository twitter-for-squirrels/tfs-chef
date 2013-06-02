secrets = Chef::EncryptedDataBagItem.load("secrets", "mysql")
if secrets && mysql_passwords = secrets[node.chef_environment]
  node['mysql']['server_root_password'] = mysql_passwords['root']
  node['mysql']['server_debian_password'] = mysql_passwords['debian']
  node['mysql']['server_repl_password'] = mysql_passwords['repl']
end

include_recipe "mysql::server"
