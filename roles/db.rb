name "db"
description "db server"
all_env = [
  "role[base]",
  "recipe[mysql-tfs::server]"
]

run_list(all_env)

env_run_lists(
  "_default" => all_env,
  "prod" => all_env
)
