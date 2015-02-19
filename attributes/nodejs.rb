# Do we want an nginx proxy for our nodejs install?
default['tiddlywiki5']['nodejs']['nginx_proxy'] = true

override['nginx']['install_method'] = 'source'

# Do we want the nginx proxy to perform LDAP auth?
default['tiddlywiki5']['nodejs']['ldap_auth'] = false 

# NB: it will be necessary to override the ['nginx']['auth_ldap']
# attributes found in the nginx_auth_ldap cookbook in order to configure
# LDAP authentication.

# Name of site as displayed by the auth dialog:
default['tiddlywiki5']['nodejs']['ldap_secure_name'] = "Example TW5"

