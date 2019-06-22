# Encoding: utf-8
#
# Cookbook Name:: ansible-tower
# Recipe:: default
#
# Copyright 2014, Brint O'Hearn
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

installed_file = '/root/.ansible_installed'

unless File.exist?(installed_file)
  include_recipe 'python::default'
  python_pip 'ansible'

  ansible_file = 'ansible-tower-setup-latest.tar.gz'

  remote_file File.join(Chef::Config[:file_cache_path], ansible_file) do
    source node['ansible']['download_url']
  end

  package 'tar'
  package 'python-pycurl'

  servername = node['ansible']['server_name']
  admin_pass = node['ansible']['postgres']['admin_password']
  postgres_pass = node['ansible']['postgres']['admin_password']
  rbbit = node['ansible']['rabbitmq']['admin_password']

  execute 'Install Ansible Tower' do
    cwd Chef::Config[:file_cache_path]
    command <<-EOH
    tar xzf #{ansible_file}
    cd ansible-tower*
    # Modify groupvars
    sed -i 's/pg_password: AWsecret/pg_password: #{postgres_pass}/' \
    ansible-tower*/group_vars/all
    sed -i 's/admin_password: password/admin_password: #{admin_pass}/' \
    ansible-tower*/group_vars/all
    sed -i 's/rabbitmq_password: "AWXbunnies"/rabbitmq_password: "#{rbbit}"/' \
    ansible-tower*/group_vars/all
    sed -i 's/httpd_server_name: localhost/httpd_server_name: #{servername}/' \
    ansible-tower*/group_vars/all
    sed -i 's/ - localhost/ - #{servername}/' ansible-tower*/group_vars/all
    # Install
    cd ansible-tower*
    ./setup.sh
    cd ..
    # Cleanup
    rm -rf ansible-tower*
    EOH
  end

  file installed_file do
    owner 'root'
    group 'root'
    mode '0600'
  end
end
