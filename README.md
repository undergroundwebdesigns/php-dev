PHP LAMP Server
===============

This repository contains Vagrant / Chef configuration designed to make it very easy to create and manage a self-contained development environment for PHP projects.

Dependancies
------------

This repository depends on [Vagrant](http://www.vagrantup.com/downloads.html), the [Vagrant Omnibus Plugin](https://github.com/schisamo/vagrant-omnibus), and the [Vagrant Berkshelf Plugin](https://github.com/berkshelf/vagrant-berkshelf). The rest of this guide will assume that Vagrant and both plugins have been installed on your development machine. Note that this repository was created & tested against Vagrant 1.4, and likely will NOT work as expected with earlier versions.

Setup
-----

1. Fork this repository. This repository is meant to serve as a convenient baseline that WILL be customized to your specific project. As such it is strongly recommended that you fork it before cloning.
2. Clone your fork onto your development machine.
3. Edit the attributes/default.rb file to match your PHP project. If you provide a value for the git_repo option, Chef will clone your PHP code into place. If no git_repo is given the system will assume that you are going to manually place your code into the sites/<app_name> folder (where app_name is the "name" value in attributes/default.rb).
4. Create a user file in data_bags/users/. The file alex.json is mine, and gives an example of what these files can look like. Multiple users can be created by placeing multiple files in data_bags/users. For more information on configuring users please see the [users](https://github.com/opscode-cookbooks/users) cookbook. This repo makes use of the users::sysadmins recipe.
5. From the root directory of the repo, run `vagrant up`. This will begin the process of creating your VM, downloading the base image if necessary, configuring and booting it, and running chef to provision it. This step will probably take a while... feel free to grab a coffee.
6. Edit your /etc/hosts file to point the domain name you set in attributes/default.rb to 192.168.33.10. (You can do this step while the VM is being created).
7. Once your VM has been successfully created you should be able to navigate to your project's domain name and see your project (or an Apache 404 error if you didn't provide a git_repo for your project files).

Further Information
-------------------

I have attempted to show how chef roles & environments can be used to customize the machine(s) being created, and it should be relatively simple to expand the code in this repository to run multiple servers instead of one (look at the [Vagrant MultiMachine docs](http://docs.vagrantup.com/v2/multi-machine/index.html) and the contents of the roles/ directory).

This repository makes use of chef-solo for provisioning, but I have attempted to keep the chef recipes themselves free from chef-solo specific code, so modifying the setup to run against a chef server should be straightforward. That said, this has not been tested, and your mileage may vary.
