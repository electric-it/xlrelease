# ==================================================
# Java setup
# ==================================================
include_recipe "java::default"

# ==================================================
# Setup OS users and groups
# ==================================================
group 'xlrelease' do
  action :create
  group_name node['xlrelease']['group']
end

# ==================================================
# This user will run XL Release
# ==================================================
user 'xlrelease' do
  action :create
  username  node['xlrelease']['user']
  gid       node['xlrelease']['group']
  comment   "XL Release system user"
  system    true
  shell     "/bin/false"
end

# ==================================================
# Download XL Release install zip
# ==================================================
remote_file "#{node['xlrelease']['installdir']}/#{node['xlrelease']['filename']}" do
  source node['xlrelease']['downloadurl']
end

# ==================================================
# Unzip install zip
# ==================================================
package "unzip" do
  action :install
end
execute "unzip installation archive" do
  command "unzip #{node['xlrelease']['installdir']}/#{node['xlrelease']['filename']} -d #{node['xlrelease']['installdir']}"
end

# ==================================================
# Chown install directory
# ==================================================
execute "update ownership" do
  command "chown -R xlrelease:xlrelease #{node['xlrelease']['home']}"
end

# ==================================================
# Create the input file for the installer
# ==================================================
template "setup-config" do
  source  "setup-config.txt.erb"
  path    "#{node['xlrelease']['home']}/setup-config.txt"
  owner   node['xlrelease']['user']
  group   node['xlrelease']['group']
  mode    "0600"
    variables(
    :adminpassword  => node['xlrelease']['adminpassword'],
    :repository  => node['xlrelease']['repository'],
    :threads  => node['xlrelease']['threads'],
    :ssl  => node['xlrelease']['ssl'],
    :csre  => node['xlrelease']['csre'],
    :http_bind  => node['xlrelease']['http_bind'],
    :http_context_root  => node['xlrelease']['http_context_root'],
    :threads_max  => node['xlrelease']['threads_max'],
    :cstm => node['xlrelease']['cstm'],
    :hide_internals => node['xlrelease']['hide_internals'],
    :import_packages => node['xlrelease']['import_packages'],
    :port => node['xlrelease']['port']
    )

  notifies :run, 'execute[install-xlrelease]', :immediately
end

# ==================================================
# Run the installer
# ==================================================
execute "install-xlrelease" do
  user    node['xlrelease']['user']
  group   node['xlrelease']['group']
  cwd     "#{node['xlrelease']['home']}/bin"
  command "./server.sh -setup -reinitialize -force -setup-defaults #{node['xlrelease']['home']}/setup-config.txt &> #{node['xlrelease']['home']}/install.log"
  creates "#{node['xlrelease']['home']}/install.log"
  action :nothing
end

# ==================================================
# Runit configuration
# ==================================================
include_recipe "runit::default"

# ==================================================
#Create the service resource
# ==================================================
runit_service "xlrelease" do
  sv_dir "/etc/sv"
  service_dir "/etc/service"
  owner node['xlrelease']['user']
  group node['xlrelease']['group']
end

directory "/etc/sv/xlrelease/control" do
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

template '/etc/sv/xlrelease/control/d' do
  source 'sv-xlrelease-java-down.erb'
  owner 'root'
  group 'root'
  mode '0744'
end