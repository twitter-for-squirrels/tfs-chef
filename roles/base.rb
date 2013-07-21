name "base"
description "Base role applied to all nodes."
run_list(
  "recipe[chef-client]",
  "recipe[users::sysadmins]",
  "recipe[sudo]",
  "recipe[apt]",
  "recipe[git]",
  "recipe[build-essential]",
  "recipe[vim]",
  "recipe[mysql::client]",
  "recipe[database::mysql]"
)
override_attributes(
  :authorization => {
    :sudo => {
      :users => ["ubuntu"],
      :passwordless => true
    }
  }
)
