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

If you have Vagrant installed and configured locally, you should be able to run `vagrant up` to get a working
installation. Override the attributes above to tweak the deployment.

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

