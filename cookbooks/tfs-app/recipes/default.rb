#
# Cookbook Name:: tfs-app
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

deploy_branch "/var/www/tfs" do
	repo "https://github.com/twitter-for-squirrels/twitter-for-squirrels.git"
	enable_submodules true
	branch "master"

	migrate true
	migrate_command "minion migrations::run"

	notifies :restart, "service[apache]"
end
