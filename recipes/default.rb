#
# Cookbook Name:: php-dev
# Recipe:: default

# NOTE: It's important that apt be run first
# as other recipes that try to install
# packages may fail if it hasn't been run.
include_recipe "apt"

# Instal git, vim, and build-essential:
include_recipe "git"
include_recipe "build-essential"
include_recipe "vim"

# Install PHP:
include_recipe "php"

# Install MySQL:
include_recipe "mysql::server"

# Install Apache 2 with PHP and SSL modules:
include_recipe "apache2"
include_recipe "apache2::mod_php5"
include_recipe "apache2::mod_ssl"


unless node["php_apps"].empty?
  node["php_apps"].each_pair do |name, attrs|
    attrs["name"] ||= name

    # If given a git repo, attempt to clone / sync it:
    unless attrs["git_repo"].nil?

      # Ensure this source is added to the known hosts file or git wil fail:
      repo_host = attrs["git_repo"].split("@").last.split(":").first
      ssh_known_hosts repo_host do
        hashed false
      end

      # Git checkout:
      git "/data/#{attrs["name"]}/" do
        repository attrs["git_repo"]
        reference attrs["git_branch"] || "master"
        action :checkout
      end
    end

    # Configure apache to serve this site:
    web_app attrs["name"] do
      server_name attrs["domain_name"] || node['hostname']
      server_aliases [node['fqdn']] + (attrs["aliases"] || [])
      docroot "/data/#{attrs["name"]}/#{attrs["docroot"]}"
      cookbook "apache2"
    end
  end
end
