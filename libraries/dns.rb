begin
    require 'fog'
rescue
    Chef::Log.warn("Skipping RSDNS due to missing gem 'fog'")
end

module Rackspace
  module DNS

    def dns
      begin
        creds = Chef::EncryptedDataBagItem.load("rackspace", "cloud")
      rescue Exception => e
        creds = {'username' => nil, 'apikey' => nil, 'auth_url' => nil }
      end

      apikey = new_resource.rackspace_api_key || creds['apikey']
      username = new_resource.rackspace_username || creds['username']
      auth_url = new_resource.rackspace_username || creds['auth_url']
      @@dns ||= Fog::DNS.new(:rackspace_api_key => apikey, :rackspace_username => username,
                             :rackspace_auth_url => auth_url,
                             :raise_errors => node['rsdns']['abort_on_failure'])
      @@dns
    end
  end
end