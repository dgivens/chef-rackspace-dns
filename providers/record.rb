include Rackspace::DNS

action :create do
  if current_resource.nil?
    Chef::Log.info("Creating new record #{new_resource.name}")
    if zone
        record.create()
        new_resource.updated_by_last_action(true)
    else
        Chef::Log.warn("Domain #{new_resource.domain} for #{new_resource.name} does not exist")
        new_resource.updated_by_last_action(false)
    end
  else
    same = true
    ['name', 'data', 'ttl', 'priority'].each do |attribute|
      if new_resource.attribute != current_resource.attribute
        same = false
      end
    end

    if !same
      Chef::Log.info("Updating record #{new_resource.name}")
      record.update(:name => new_resource.name,
                    :data => new_resource.data,
                    :ttl => new_resource.ttl, 
                    :priority => new_resource.priority)
      record.save
      new_resource.updated_by_last_action(true)
    else
      Chef::Log.info("No update for record #{new_resource.name} necessary")
      new_resource.updated_by_last_action(false)
    end
  end
end

action :delete do
  if current_resource.nil?
    Chef::Log.info("Record #{new_resource.name} does not exist")
    new_resource.updated_by_last_action(false)
  else
    Chef::Log.info("Removing record #{new_resource.name}")
    record.destroy
  end
end

def load_current_resource
  @zone = dns.zones.find{|z| z.domain == new_resource.domain}
  @record = zone.records.find{|r| r.name == new_resource.name && r.type == new_resource.type}
  if record
    @current_resource.name = record.name
    @current_resource.domain = zone.name
    @current_resource.data = record.data
    @current_resource.type = record.type
    @current_resource.ttl = record.ttl
    @current_resource.priority = record.priority
  end
  @current_resource
end