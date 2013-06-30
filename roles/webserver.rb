name "webserver"
description "Web server role"
all_env = [
  "role[base]",
  "recipe[php]",
  "recipe[php::module_mysql]",
  "recipe[apache2]",
  "recipe[apache2::mod_php5]",
  "recipe[apache2::mod_rewrite]",
  "recipe[tfs-app::default]"
]

run_list(all_env)

env_run_lists(
  "_default" => all_env,
  "prod" => all_env
)
