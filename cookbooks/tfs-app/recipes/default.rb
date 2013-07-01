#
# Cookbook Name:: tfs-app
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

secrets = Chef::EncryptedDataBagItem.load("secrets", "mysql")

MYSQL_USER = "debian"

deploy_branch "/var/www/tfs" do
	action :force_deploy

	repo "https://github.com/twitter-for-squirrels/twitter-for-squirrels.git"
	enable_submodules true
	branch "develop"
	shallow_clone false

	if node.roles.include? "db"
		mysql_server = node
	else
		mysql_server = search(:node, "role:db").first
	end

	before_migrate do

		template "#{release_path}/application/config/database.php" do
			source "database.php.erb"
			variables({
				:mysql_host => mysql_server["ipaddress"],
				:mysql_user => MYSQL_USER,
				:mysql_password => secrets[node.chef_environment][MYSQL_USER],
			})
		end
	end

	migrate true
	migration_command "./minion migrations:run"

	purge_before_symlink([])
  create_dirs_before_symlink([])
  symlinks({})
  symlink_before_migrate({})

	notifies :restart, "service[apache2]"
end
