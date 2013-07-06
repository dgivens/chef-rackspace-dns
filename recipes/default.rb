#
# Cookbook Name:: rsdns
# Recipe:: default
#
# Copyright 2013, Rackspace
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

package( "libxslt-dev" ).run_action( :install )
package( "libxml2-dev" ).run_action( :install )
package( "build-essential" ).run_action( :install )

chef_gem "fog"
chef_gem "dnsruby"

begin
  # Access the Rackspace Cloud encrypted data_bag
  raxcloud = Chef::EncryptedDataBagItem.load("rackspace","cloud")

  #Create variables for the Rackspace Cloud username and apikey
  node.set['rsdns']['rackspace_username'] = raxcloud['username']
  node.set['rsdns']['rackspace_api_key'] = raxcloud['apikey']
  node.set['rsdns']['rackspace_auth_region'] = raxcloud['region'] || 'notset'
  node.set['rsdns']['rackspace_auth_region'] = node['rsdns']['rackspace_auth_region'].downcase

  if node['rsdns']['rackspace_auth_region'] == 'us'
    node.set['rsdns']['rackspace_auth_url'] = 'https://identity.api.rackspacecloud.com/v2.0'
  elsif node['rsdns']['rackspace_auth_region']  == 'uk'
    node.set['rsdns']['rackspace_auth_url'] = 'https://lon.identity.api.rackspacecloud.com/v2.0'
  else
    Chef::Log.info "Using the encrypted data bag for rackspace cloud but no raxregion attribute was set (or it was set to something other then 'us' or 'uk'). Assuming 'us'. If you have a 'uk' account make sure to set the raxregion in your data bag"
    node.set['rsdns']['rackspace_auth_url'] = 'https://identity.api.rackspacecloud.com/v2.0'
  end
rescue Exception => e
  Chef::Log.error "Failed to load rackspace cloud data bag: " + e.to_s
end

if node[:rsdns][:rackspace_username] == 'your_rackspace_username' || node['rsdns']['rackspace_api_key'] == 'your_rackspace_api_key'
  Chef::Log.info "Rackspace username or api key has not been set. For this to work, either set the default attributes or create an encrypted databag of rackspace cloud per the cookbook README"
end