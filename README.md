# chef-rackspace-dns

# Description

Adds resources for managing DNS zones and records in Rackspace DNS

# Requirements

A [Rackspace Cloud](http://www.rackspace.com/cloud/) account is required to use
this cookbook. You will need a valid username and API key to authenticate into
your account.

You can sign up for an account [here](https://cart.rackspace.com/cloud/).

## Dependencies

The following dependencies are installed via rsdns::default.

### Packages

* libxml2-dev
* libxslt-dev

### Gems

* [fog](http://fog.io/) 
* [rubydns](http://rubyforge.org/projects/dnsruby/)

# Usage

## Account Credentials

It is highly recommended you store your Rackspace Cloud authentication
credentials in an encrypted data bag. This cookbook looks for an encrypted
data bag `rackspace` and the `cloud` data bag item. The item should look like
the following.

```json
    {
      "id": "cloud",
      "username": "your_rackspace_username",
      "apikey": "your_rackspace_api_key",
      "region": "[us|uk]"
    }
```

`region` should be set to `us` or `uk`, depending on where your account was
created. If you signed up for your Rackspace Cloud account through 
rackspace.com, then you have a `us` account. If you signed up through 
rackspace.co.uk, then you have a `uk` account. The default if neither is 
supplied is `us`.

Alternatively, you can set the credentials through attributes.

```ruby
    default[:rsdns][:rackspace_username] = 'your_rackspace_username'
    default[:rsdns][:rackspace_api_key] = 'your_rackspace_api_key'
    default[:rsdns][:rackspace_auth_region] = '[us|uk]'
```

## Resources

### Record

This is an example of creating an A record for the host via recipe. It assumes
that the domain for `node[:domain]` exists as a domain on your Rackspace Cloud
account. See the Zone resource for creating a zone via recipe.

```ruby
    rsdns_record node[:fqdn] do
      domain node[:domain]
      value node[:ipaddress]
      type 'A'
      ttl 300
    end
```

The only required attributes are `domain` and `value`. The available attributes 
are:

* `name` - Defaults to the name of the resource
* `domain` - Required
* `value` - Required (Example: IP Address an A record should resolve to)
* `type` - Default 'A'
* `ttl` - Default '300' (String or Integer is fine)
* `priority` - Default `nil`, but useful with MX and TXT records

### Zone

This is an example of creating a new domain (also known as a zone) via recipe.

```ruby
    rsdns_zone node[:domain] do
      email 'foo@bar.com'
      ttl 300
    end
```

The only required attribute is `email`. `ttl` defaults to 300.

# Attributes

```ruby
    default[:rsdns][:rackspace_username] = 'your_rackspace_username'
    default[:rsdns][:rackspace_api_key] = 'your_rackspace_api_key'
    default[:rsdns][:rackspace_auth_region] = '[us|uk]'
```

# Recipes

## default.rb

Installs the necessary packages and ruby gems.
