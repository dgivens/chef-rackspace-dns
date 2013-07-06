include Rackspace::DNS

actions :create, :delete

attribute :domain, :kind_of => String
attribute :email, :kind_of => String, :required => true
attribute :ttl, :kind_of => [String, Integer], :default => 300

def initialize(*args)
  super
  @action = :create
  @domain ||= @name
end