name "base"
description "Base role, to be applied to all nodes."

run_list(
  "recipe[users::sysadmins]",
  "recipe[sudo]",
  "recipe[apt]",
  "recipe[git]",
  "recipe[build-essential]",
  "recipe[vim]",
)
override_attributes(
  authorization: {
    sudo: {
      users: ["ubuntu", "vagrant"],
      passwordless: true,
    }
  }
)
