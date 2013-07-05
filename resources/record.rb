actions :create, :delete

attribute :name, :type_of => String, :name_attribute => true
attribute :value, :type_of => String, :required => true
attribute :type, :type_of => String, :default => 'A'
attribute :ttl, :type_of => [String, Integer], :default => '300'

def initialize(*args)
  super
  @action = :create
end