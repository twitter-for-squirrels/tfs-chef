name "base"
description "Base role applied to all nodes."
run_list(
  "recipe[chef-client]",
  "recipe[users::sysadmins]",
  "recipe[apt]",
  "recipe[sudo]",
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
