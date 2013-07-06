include Rackspace::DNS

actions :create, :delete

attribute :name, :kind_of => String, :name_attribute => true
attribute :domain, :kind_of => String, :required => true
attribute :value, :kind_of => String, :required => true
attribute :type, :kind_of => String, :default => 'A'
attribute :ttl, :kind_of => [String, Integer], :default => '300'
attribute :priority, :kind_of => [String, Integer, NilClass], :default => nil
attribute :rackspace_username, :kind_of => [String, NilClass], :default => nil
attribute :rackspace_api_key, :kind_of => [String, NilClass], :default => nil
attribute :rackspace_auth_url, :kind_of => [String, NilClass], :default => nil

def initialize(*args)
  super
  @action = :create
end