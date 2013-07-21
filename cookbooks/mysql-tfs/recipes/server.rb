secrets = Chef::EncryptedDataBagItem.load("secrets", "mysql")
mysql_passwords = secrets[node.chef_environment]
if not node.attribute?("mysql")
	node['mysql']['server_root_password'] = mysql_passwords['root']
	node['mysql']['server_repl_password'] = mysql_passwords['repl']

	node['mysql']['server_app_password'] = mysql_passwords['app']
end

include_recipe "mysql::server"

mysql_conn_info = {
	:host => 'localhost',
	:username => 'root',
	:password => node['mysql']['server_root_password']
}

mysql_database "web_app" do
	connection mysql_conn_info

	encoding 'utf8mb4'

	action :create
end


# create mysql user for the app
mysql_database_user "app" do
	connection mysql_conn_info

	password mysql_passwords["app"]
	database_name "web_app"

	host "%"

	privileges [ :select, :insert, :update, :delete, :create, :alter, :index ]

	action :create
end
