include Rackspace::DNS

actions :create, :delete

attribute :name, :type_of => String, :name_attribute => true
attribute :domain, :type_of => String, :required => true
attribute :data, :type_of => String, :required => true
attribute :type, :type_of => String, :default => 'A'
attribute :ttl, :type_of => [String, Integer], :default => '300'
attribute :priority, :type_of => [String, Integer, NilClass], :default => nil

def initialize(*args)
  super
  @action = :create
end