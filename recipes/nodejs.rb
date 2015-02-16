#
# Cookbook Name:: tiddlywiki5
# Recipe:: nodejs
#
# Copyright (C) 2015 AzTek Native Ltd.
#
# All rights reserved - Do Not Redistribute
#

# Ensure user/group exists
include_recipe "tiddlywiki5::user"

# Deploy TiddlyWiki from Github 
application "tiddlywiki5" do

  path node['tiddlywiki5']['tw5_path']
  owner node['tiddlywiki5']['user']
  group node['tiddlywiki5']['user']
  packages ["git"]

  repository "https://github.com/Jermolene/TiddlyWiki5.git"

  # This is a bit of a hack atm; should only be run on first deploy; will error otherwise.
  # TODO: consider use of wrapper script that checks for aleady initialised wiki path.
  migrate true
  migration_command "node tiddlywiki.js #{node['tiddlywiki5']['tw5_path']}/shared/wiki/ --init"

  nodejs do
    entry_point "tiddlywiki.js #{node['tiddlywiki5']['tw5_path']}/shared/wiki/ --server #{node['tiddlywiki5']['tw5_port']} $:/core/save/all text/plain text/html \"\" \"\" 0.0.0.0"
    npm true
  end

  # Check if we want nginx deployed in front of TW5
  if node['tiddlywiki5']['nodejs']['nginx_proxy'] == true
    nginx_load_balancer do
      hosts [ '127.0.0.1' ]
      template "load_balancer.conf.erb"
      server_name node['tiddlywiki5']['site_hostname']
      application_port node['tiddlywiki5']['tw5_port']
      set_host_header true
    end
  end

end

