include Rackspace::DNS

actions :create, :delete

attribute :domain, :kind_of => String
attribute :email, :kind_of => String, :required => true
attribute :ttl, :kind_of => [String, Integer], :default => 300
attribute :rackspace_username, :kind_of => [String, NilClass], :default => nil
attribute :rackspace_api_key, :kind_of => [String, NilClass], :default => nil
attribute :rackspace_auth_url, :kind_of => [String, NilClass], :default => nil

def initialize(*args)
  super
  @action = :create
  @domain ||= @name
end