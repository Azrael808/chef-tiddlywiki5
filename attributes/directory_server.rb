# Hostname for the master LDAP directory
default['tiddlywiki5']['master-ldap'] = "dirsrv.example.com"

default['tiddlywiki5']['domain'] = "tiddlywiki5.example.com"

# Top-level Suffix for the directory
default['tiddlywiki5']['suffix'] = "dc=tiddlywiki5,dc=example,dc=com"

# Default credentials. In production use, these hashes should be dropped in favour of strings that reference named data bags
default['tiddlywiki5']['dirsrv_credentials'] = { "bind_dn" => "cn=Directory Manager",
                                                 "password" => "Testing1234",
                                                 "user" => "manager"
                                               }
default['tiddlywiki5']['cfgsrv_credentials'] = { "bind_dn" => "cn=admin",
                                                 "password" => "Testing1234",
                                                 "username" => "manager"
                                               }

# Recommended sysctl params from the dirsrv cookbook
override['sysctl']['params']['fs']['file_max'] = 64000
override['sysctl']['params']['ipv4']['tcp_keepalive_time'] = 30
override['sysctl']['params']['ipv4']['ip_local_port_range'] = '1024 65000'

# Make sure to configure EPEL repos
override['dirsrv']['use_yum_epel'] = true

# Override to ensure nginx is compile with auth_ldap module
override['tiddlywiki5']['nodejs']['ldap_auth'] = true

# Override the nginx_auth_ldap servers attribute
override['nginx']['auth_ldap']['servers'] = {
  "dirsrv" => {
    "basedn" => "dc=tiddlywiki5,dc=example,dc=com",
    "host" => "dirsrv.example.com",
    "ssl" => false,
    "port" => 389,
    "user_attribute" => "uid",
    "user_class" => "inetOrgPerson",
    "binddn" => "uid=tiddlywiki,ou=Service Accounts,dc=tiddlywiki5,dc=example,dc=com",
    "binddn_password" => "Testing1234",
    "require" => "valid_user"
  }
}

