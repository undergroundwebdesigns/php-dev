#
# Cookbook Name:: php-dev
# Recipe:: default

#include_recipe "users::sysadmins"

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
      server_aliases attrs["aliases"] || []
      docroot "/data/#{attrs["name"]}/#{attrs["docroot"]}"
      cookbook "apache2"
    end
  end
end
