#
# Cookbook Name:: tiddlywiki5
# Recipe:: nodejs
#
# Copyright (C) 2015 AzTek Native Ltd.
#
# All rights reserved - Do Not Redistribute
#
#

%w{ apt
    couchdb
    nodejs
    tiddlywiki5::user }.each do |r|

  include_recipe r
end

# Create the database on CouchDB
couchdb_database node['tiddlywiki5']['couchdb_name'] do
  couchdb_user "tw5_admin"
  couchdb_password node['couch_db']['config']['admins']['tw5_admin']
end

# Install TW5 globally
nodejs_npm "tiddlywiki"

package "git"

# Deploy couchadapter
deploy_revision node['tiddlywiki5']['couchdb_adaptor_path'] do
  user node['tiddlywiki5']['user']
  group node['tiddlywiki5']['user']
  repository "https://github.com/wshallum/couchadaptor.git"
  migrate false
  symlink_before_migrate({})
end

# Need to install couchapp locally, not globally...
nodejs_npm "couchapp" do
  path "#{node['tiddlywiki5']['couchdb_adaptor_path']}/current"
  user node['tiddlywiki5']['user']
  group node['tiddlywiki5']['user']
end

# Drop in configuration file for couchapp to upload TW5
file "#{node['tiddlywiki5']['couchdb_adaptor_path']}/current/push_settings" do
  content "DB_URL=\"http://tw5_admin:#{node['couch_db']['config']['admins']['tw5_admin']}@#{node['couch_db']['config']['httpd']['bind_address']}:#{node['couch_db']['config']['httpd']['port']}/#{node['tiddlywiki5']['couchdb_name']}\""
  user node['tiddlywiki5']['user']
  group node['tiddlywiki5']['user']
  mode "0644"
end

# Run script to upload TW5
bash "upload-tw5" do
  cwd "#{node['tiddlywiki5']['couchdb_adaptor_path']}/current"
  code "./bin/push.sh && sleep 5"
  user node['tiddlywiki5']['user']
end

