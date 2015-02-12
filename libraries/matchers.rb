if defined?(ChefSpec)
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
