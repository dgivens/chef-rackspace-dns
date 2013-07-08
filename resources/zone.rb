#
# Cookbook Name:: rsdns
# Resource:: zone
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

attribute :domain, :kind_of => String
attribute :email, :kind_of => String, :required => true
attribute :ttl, :kind_of => [String, Integer], :default => 300
attribute :rackspace_username, :kind_of => [String, NilClass], :default => nil
attribute :rackspace_api_key, :kind_of => [String, NilClass], :default => nil
attribute :rackspace_auth_url, :kind_of => [String, NilClass], :default => nil

def initialize(*args)
  super
  @action = :create
  @domain ||= @name
  @rackspace_username ||= node[:rsdns][:rackspace_username]
  @rackspace_api_key ||= node[:rsdns][:rackspace_api_key]
  @rackspace_auth_url ||= node[:rsdns][:rackspace_auth_url]
end