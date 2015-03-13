# ==================================================
# XL Release version to install
# ==================================================
default['xlrelease']['version'] = '4.0.17'

# ==================================================
# Home directory for XL Release
# ==================================================
default['xlrelease']['installdir'] = '/opt'
default['xlrelease']['home'] = "#{node['xlrelease']['installdir']}/xl-release-#{node['xlrelease']['version']}-server"

# ==================================================
# The user/group to run as
# ==================================================
default['xlrelease']['user'] = 'xlrelease'
default['xlrelease']['group'] = 'xlrelease'

# ==================================================
# Below attributes used to setup-config.txt for input into xlrelease installer
# ==================================================
default['xlrelease']['adminpassword'] = "password"
default['xlrelease']['repository'] = "repository"
default['xlrelease']['threads'] = "3"
default['xlrelease']['ssl'] = "false"
default['xlrelease']['csre'] = "true"
default['xlrelease']['http_bind'] = '0.0.0.0'
default['xlrelease']['http_context_root'] = '/'
default['xlrelease']['threads_max'] = '24'
default['xlrelease']['cstm'] = '0'
default['xlrelease']['hide_internals'] = 'false'
default['xlrelease']['import_packages'] = 'importablePackages'
default['xlrelease']['port'] = '5516'

# ==================================================
# wget attributes
# ==================================================
default['xlrelease']['filename'] = "xl-release-#{node['xlrelease']['version']}-server.zip"
default['xlrelease']['username'] = 'supplied by xebialabs'
default['xlrelease']['password'] = 'supplied by xebialabs'
default['xlrelease']['downloadurl'] = "https://dist.xebialabs.com/xl-release/4.0.17/#{node['xlrelease']['filename']}"