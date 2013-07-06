#
# Cookbook Name:: rsdns
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
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