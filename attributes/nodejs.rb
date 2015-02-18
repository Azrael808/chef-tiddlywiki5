# Do we want an nginx proxy for our nodejs install?
default['tiddlywiki5']['nodejs']['nginx_proxy'] = true

override['nginx']['install_method'] = 'source'

# Do we want the nginx proxy to perform LDAP auth?
default['tiddlywiki5']['nodejs']['ldap_auth'] = true

default['tiddlywiki5']['nodejs']['ldap_basedn'] = "dc=example,dc=com"

# Details for binding to the directory server.
default['tiddlywiki5']['nodejs']['ldap_url'] = "ldap://ldap.example.com:389/#{node['tiddlywiki5']['nodejs']['ldap_basedn']}?sAMAccountName?sub?(objectClass=person)"
default['tiddlywiki5']['nodejs']['ldap_binddn'] = "uid=tiddlywiki,ou=Service Accounts,#{node['tiddlywiki5']['nodejs']['ldap_basedn']}"
default['tiddlywiki5']['nodejs']['ldap_binddn_password'] = "changeme"

# Name of site as displayed by the auth dialog:
default['tiddlywiki5']['nodejs']['ldap_secure_name'] = "Example TW5"

