name "webserver"
description "Web server role"
all_env = [
  "role[base]",
  "recipe[php]",
  "recipe[php::module_mysql]",
  "recipe[apache2]",
  "recipe[apache2::mod_php5]",
  "recipe[apache2::mod_rewrite]",
  "recipe[tfs-apache::web_apps]",
  "recipe[tfs-app::default]"
]

run_list(all_env)

env_run_lists(
  "_default" => all_env,
  "prod" => all_env
)

override_attributes(
  :tfs_apache => {
    :web_apps => [{
      :server_name => "tfs.dev.ec2",
      :server_aliases => ["www.tfs.dev.ec2"],
      :docroot => "/var/www/tfs/current/httpdocs",
      :app_environment => "production",
      :aliases => []
    }]
  }
)
