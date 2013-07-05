begin
    require 'fog'
rescue
    Chef::Log.warn("Missing gem 'fog'")
end