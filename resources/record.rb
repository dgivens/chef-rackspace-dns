#
# Cookbook Name:: rsdns
# Resource:: record
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

actions :create, :delete

attribute :name, :kind_of => String, :name_attribute => true
attribute :domain, :kind_of => String, :required => true
attribute :value, :kind_of => String, :required => true
attribute :type, :kind_of => String, :default => 'A'
attribute :ttl, :kind_of => [String, Integer], :default => '300'
attribute :priority, :kind_of => [String, Integer, NilClass], :default => nil
attribute :rackspace_username, :kind_of => [String, NilClass], :default => nil
attribute :rackspace_api_key, :kind_of => [String, NilClass], :default => nil
attribute :rackspace_auth_region, :kind_of => [String, NilClass], :default => 'us'

def initialize(*args)
  super
  @action = :create
  @rackspace_username ||= node[:rsdns][:rackspace_username]
  @rackspace_api_key ||= node[:rsdns][:rackspace_api_key]
  @rackspace_auth_region ||= node[:rsdns][:rackspace_auth_region]
end