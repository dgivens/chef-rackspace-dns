actions :create, :delete

attribute :name, :kind_of => String, :name_attribute => true
attribute :email, :kind_of => String, :required => true
attribute :ttl, :kind_of => [String, Integer], :default => 300

def initialize(*args)
  super
  @action = :create
end