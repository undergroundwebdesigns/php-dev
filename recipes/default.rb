#
# Cookbook Name:: php-dev
# Recipe:: default

# NOTE: It's important that apt be run very early
# if not first, as other recipes that try to install
# packages may fail if it hasn't been run.
include_recipe "apt"
include_recipe "git"
include_recipe "build-essential"
include_recipe "vim"

# Install PHP:
include_recipe "php"

# Install MySQL:
include_recipe "mysql::server"

# Install Apache 2:
include_recipe "apache2"
include_recipe "apache2::mod_php5"
include_recipe "apache2::mod_ssl"
