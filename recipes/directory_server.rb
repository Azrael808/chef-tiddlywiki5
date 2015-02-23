#
# Cookbook Name:: tiddlywiki5
# Recipe:: directory_server
#
# Copyright 2015, Postshift LLP
#
# All rights reserved - Do Not Redistribute
#

%w{ sysctl::apply
    dirsrv }.each do |p|

  include_recipe p

end

# Disable the local firewall
service "iptables" do
  action [ :disable, :stop ]
end

# Drop pre-seed ldif file onto FS
template "/tmp/preseed.ldif" do
  source "preseed.ldif.erb"
  owner "root"
  group "dirsrv"
  mode "0640"
end

# Create hosts file entry for FQDN
hostsfile_entry node['ipaddress'] do
  hostname node['tiddlywiki5']['master-ldap']
end

# Create 389 server instance
dirsrv_instance "tiddlywiki5_master" do
  host                 node['tiddlywiki5']['master-ldap']
  suffix               node['tiddlywiki5']['suffix']
  credentials          node['tiddlywiki5']['dirsrv_credentials']
  preseed_ldif         "/tmp/preseed.ldif"
  is_cfgdir            true
  has_cfgdir           true
  cfgdir_addr          node['ipaddress']
  cfgdir_domain        node['tiddlywiki5']['domain']
  cfgdir_ldap_port     389
  cfgdir_credentials   node['tiddlywiki5']['cfgsrv_credentials']
  action               [ :create, :start ]
end

include_recipe "tiddlywiki5"


