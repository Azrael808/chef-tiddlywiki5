name             'tiddlywiki5'
maintainer       'AzTek Native Ltd.'
maintainer_email 'peter.green@aztek-native.com'
license          'Apache 2.0'
description      'Installs/Configures tiddlywiki5'
long_description 'Installs/Configures tiddlywiki5'
version          '0.1.0'
%w{ application
    application_nginx
    application_nodejs }.each do |d|

  depends          d
end
