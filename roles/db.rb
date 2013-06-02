name "db"
description "db server"
all_env = [
  "role[base]",
  "recipe[mysql::server]"
]

run_list(all_env)

env_run_lists(
  "prod" => all_env
)
