#
# Cookbook Name:: tiddlywiki5
# Recipe:: user
#
# Copyright (C) 2015 AzTek Native Ltd.
#
# All rights reserved - Do Not Redistribute
#

group node['tiddlywiki5']['user']

user node['tiddlywiki5']['user'] do
  action :create
  group node['tiddlywiki5']['user']
end

