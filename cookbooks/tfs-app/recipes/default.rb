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
	migrate false

	branch "master"

	enable_submodules true

	notifies :restart, "service[apache]"
end
