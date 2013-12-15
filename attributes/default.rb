# The php_apps is a hash of app configs which will be used to configure
# apache. These configurations can take git details (repository and branch)
# in which case they will clone the repository into sites/<app_name>/.
default["php_apps"]["sample_app"] = {
  "name" => "sample_app",
  "domain_name" => "local.sample_app.com",
  "aliases" => [],
  
  # Each app is assumed to live in sites/<app_name>. The docroot given
  # here is relative to that path, allowing some files to be placed below
  # the doc-root for security purposes.
  "docroot" => "public/", 
  
  # If a git_repo value is specified chef will attempt to check out your
  # code into the correct location for you.
  "git_repo" => nil, 
  "git_branch" => "master", 
}
