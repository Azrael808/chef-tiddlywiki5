# tiddlywiki5-cookbook

Currently downloads and configures TiddlyWiki5 from source as a NodeJS
application, optionally configuring Nginx as a proxy with or without LDAP-based authentication.

## Supported Platforms

Currently tested on the following distros:
* CentOS (6.5)
* Ubuntu (14.04)

Not currently compatible with Chef 12, because of it's dependency on the application_nginx cookbook:
https://github.com/poise/application_nginx/issues/20

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['tiddlywiki5']['user']</tt></td>
    <td>String</td>
    <td>OS user account who will "own" the TW5 installation.</td>
    <td><tt>tw5</tt></td>
  </tr>
  <tr>
    <td><tt>['tiddlywiki5']['tw5_path']</tt></td>
    <td>String</td>
    <td>Base directory used to contain the TW5 installation.</td>
    <td><tt>/srv/tw5</tt></td>
  </tr>
  <tr>
    <td><tt>['tiddlywiki5']['site_hostname']</tt></td>
    <td>String</td>
    <td>Hostname through which the TW5 instance will be accessed</td>
    <td><tt>tiddlywiki5.com</tt></td>
  </tr>
  <tr>
    <td><tt>['tiddlywiki5']['tw5_port']</tt></td>
    <td>Integer</td>
    <td>Port that the TW5 instance should bind to.</td>
    <td><tt>8080</tt></td>
  </tr>
  <tr>
    <td><tt>['tiddlywiki5']['nodejs']['nginx_proxy']</tt></td>
    <td>Boolean</td>
    <td>Decides whether or not to configure Nginx.</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['tiddlywiki5']['nodejs']['ldap_auth']</tt></td>
    <td>Boolean</td>
    <td>Decides whether or not to configure LDAP authentication.</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['tiddlywiki5']['nodejs']['ldap_basedn']</tt></td>
    <td>String</td>
    <td>Base/suffix of the LDAP directory.</td>
    <td><tt>dc=example,dc=com</tt></td>
  </tr>
  <tr>
    <td><tt>['tiddlywiki5']['nodejs']['ldap_url']</tt></td>
    <td>String</td>
    <td>URL used to query the LDAP directory when authenticating users.</td>
    <td><tt>ldap://ldap.example.com:389/dc=example,dc=com?uid?sub?(objectClass=inetorgperson)</tt></td>
  </tr>
  <tr>
    <td><tt>['tiddlywiki5']['nodejs']['ldap_binddn']</tt></td>
    <td>String</td>
    <td>Distinguished Name to bind to the LDAP directory as.</td>
    <td><tt>uid=tiddlywiki,ou=Service Accounts,dc=example,dc=com</tt></td>
  </tr>
  <tr>
    <td><tt>['tiddlywiki5']['nodejs']['ldap_binddn_password']</tt></td>
    <td>String</td>
    <td>Password to bind to the LDAP directory as.</td>
    <td><tt>changeme</tt></td>
  </tr>
  <tr>
    <td><tt>['tiddlywiki5']['nodejs']['ldap_secure_name']</tt></td>
    <td>String</td>
    <td>Name of site as displayed by the auth dialog.</td>
    <td><tt>Example TW5</tt></td>
  </tr>
</table>

## Usage

### Local Testing

To create a VM locally that contains all the components currently made available by this cookbook (NodeJS TW5 instance, nginx
proxy that authenticates with 389 directory server), please follow these steps:

1. Download and install VirtualBox for your platform: https://www.virtualbox.org/wiki/Downloads
1. Download and install Vagrant for your platform: http://www.vagrantup.com/downloads.html
1. Download and install the ChefDK for your platform: https://downloads.chef.io/chef-dk/
1. Perform any necessary post-install configuration to ensure ChefDK's binaries are available in your path.
1. Install the `vagrant-berkshelf` plugin: `vagrant plugin install vagrant-berkshelf`
1. Install the `vagrant-omnibus` plugin: `vagrant plugin install vagrant-omnibus`
1. Clone this repo (if you haven't already) and `cd` to it's root.
1. Run `vagrant up`

After a reasonable amount of time (and output), the Vagrant command should exit successfully, which should leave you with a machine
with the following port forwards configured:

* 8080 (Host) -> 80 (VM) - for connecting to Nginx / TW5.
* 3389 (Host) -> 389 (VM) - for connecting to the directory server (you'll need to use the credentials specified in the
`default['tiddlywiki5']['dirsrv_credentials'] attribute, which you can find in `attributes/directory_services.rb`).

A final step to allow nginx to map your HTTP requests to the appropriate vhost; add the following line to your `/etc/hosts` file:

```
127.0.0.1      tiddlywiki5.example.com
```


### Chef Server / Solo

To include this cookbook in a Chef run, simply add the `tiddlywiki5::default` recipe to the run list.

### tiddlywiki5::default

Include `tiddlywiki5` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[tiddlywiki5::default]"
  ]
}
```

## License and Authors

Author:: AzTek Native Ltd. (<peter.green@aztek-native.com>)

```
Copyright 2015 AzTek Native Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

