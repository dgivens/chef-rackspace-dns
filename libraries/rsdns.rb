begin
    require 'fog'
rescue LoadError
    Chef::Log.warn("Skipping RSDNS due to missing gem 'fog'")
end

module Rackspace
  module DNS

    def rsdns
      begin
        creds = Chef::EncryptedDataBagItem.load("rackspace", "cloud")
        if creds['region'] == 'us'
          auth_url = 'https://identity.api.rackspacecloud.com/v2.0'
        elsif node['rsdns']['rackspace_auth_region']  == 'uk'
          auth_url = 'https://lon.identity.api.rackspacecloud.com/v2.0'
        end
      rescue Exception => e
        creds = {'username' => nil, 'apikey' => nil, 'auth_url' => nil }
      end

      apikey = new_resource.rackspace_api_key || creds['apikey']
      username = new_resource.rackspace_username || creds['username']
      auth_url = new_resource.rackspace_auth_url || auth_url
      @@rsdns ||= Fog::DNS.new(:provider => 'Rackspace', :rackspace_api_key => apikey, 
                               :rackspace_username => username, :rackspace_auth_url => auth_url)
      @@rsdns
    end
  end
end