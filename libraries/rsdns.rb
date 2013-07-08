#
# Cookbook Name:: rsdns
# Library:: rsdns
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

begin
    require 'fog'
    require 'dnsruby'
rescue LoadError
    Chef::Log.info("Missing gems for rsnds. Will install and load them later.")
end

module Rackspace
  module DNS

    def rsdns
      begin
        creds = Chef::EncryptedDataBagItem.load("rackspace", "cloud")
      rescue Exception => e
        creds = {'username' => nil, 'apikey' => nil, 'region' => nil }
      end

      apikey = creds['apikey'] || new_resource.rackspace_api_key
      username = creds['username'] || new_resource.rackspace_username
      auth_region = creds['region'] || new_resource.rackspace_auth_region

      if auth_region == 'uk'
        auth_url = 'https://lon.identity.api.rackspacecloud.com/v2.0'
      else
        auth_url = 'https://identity.api.rackspacecloud.com/v2.0'
      end

      if username == 'your_rackspace_username' || apikey == 'your_rackspace_api_key'
        Chef::Log.warn "Rackspace username or api key has not been set. For this to work, either set the default attributes or create an encrypted databag of rackspace cloud per the cookbook README"
      end

      @@rsdns ||= Fog::DNS.new(:provider => 'Rackspace', :rackspace_api_key => apikey, 
                               :rackspace_username => username, :rackspace_auth_url => auth_url)
      @@rsdns
    end
  end
end