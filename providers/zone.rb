#
# Cookbook Name:: rsdns
# Provider:: zone
#
# Copyright 2013, Rackspace
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include Rackspace::DNS

action :create do
  zone_for_id = rsdns.zones.find{|z| z.domain == new_resource.domain}
  zone = rsdns.zones.get(zone_for_id.id)
  if zone.nil?
    Chef::Log.info("Creating new zone for #{new_resource.name}")
    dns.zones.create(:name => new_resource.name, :email => new_resource.email, :ttl => new_resource.ttl)
    new_resource.updated_by_last_action(true)
  else
    if zone.ttl != new_resource.ttl || zone.email != new_resource.email
      Chef::Log.info("Updating zone #{new_resource.name}")
      zone.ttl = new_resource.ttl
      zone.email = new_resource.email
      zone.save
      new_resource.updated_by_last_action(true)
    else
      Chef::Log.info("No updates needed for #{new_resource.name}")
      new_resource.updated_by_last_action(false)
    end
  end
end

action :delete do
  zone = rsdns.zones.find{|z| z.domain == new_resource.domain}
  if current_resource.nil?
    Chef::Log.info("Zone #{new_resource.name} does not exist")
    new_resource.updated_by_last_action(false)
  else
    Chef::Log.info("Removing zone #{new_resource.zone}")
    zone.destroy
    new_resource.updated_by_last_action(true)
  end
end