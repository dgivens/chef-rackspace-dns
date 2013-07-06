include Rackspace::DNS

action :create do
  if current_resource.nil?
    Chef::Log.info("Creating new zone for #{new_resource.name}")
    dns.zones.create(:name => new_resource.name, :email => new_resource.email, :ttl => new_resource.ttl)
    new_resource.updated_by_last_action(true)
  else
    same = true
    ['domain', 'email', 'ttl'].each do |attribute|
      if new_resource.attribute != current_resource.attribute
        same = false
      end
    end

    if !same
      Chef::Log.info("Updating zone #{new_resource.name}")
      zone.update(:ttl => new_resource.ttl, :email => new_resource.email)
      new_resource.updated_by_last_action(true)
    else
      Chef::Log.info("Not updating zone #{new_resource.name}")
      new_resource.updated_by_last_action(false)
  end
end

action :delete do
  if current_resource.nil?
    Chef::Log.info("Zone #{new_resource.name} does not exist")
    new_resource.updated_by_last_action(false)
  else
    Chef::Log.info("Removing zone #{new_resource.zone}")
    zone.destroy
  end
end

def load_current_resource
  zone_id = dns.zones.find{|z| z.domain == new_resource.name}.id
  @zone = dns.zones.get(zone_id)

  if zone
    @current_resource.name = zone.domain
    @current_resource.email = zone.email
    @current_resource.ttl = zone.ttl
  end
  @current_resource
end