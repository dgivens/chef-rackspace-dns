# define matchers for global definitions and community LWRPs lacking custom matchers
if defined?(ChefSpec)
  # stubs for the tar_extract LWRP
  ChefSpec::Runner.define_runner_method :rackspace_dns_zone
  ChefSpec::Runner.define_runner_method :rackspace_dns_record

  def create_rackspace_dns_zone(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:rackspace_dns_zone, :create, resource)
  end

  def delete_rackspace_dns_zone(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:rackspace_dns_zone, :delete, resource)
  end

  def create_rackspace_dns_record(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:rackspace_dns_record, :create, resource)
  end

  def delete_rackspace_dns_record(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:rackspace_dns_record, :delete, resource)
  end
end
