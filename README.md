# Terraform Enterprise API Client
A simple Ruby API client library for the [Terraform Enterprise API](https://www.terraform.io/docs/enterprise/api/index.html).

[![Gem Version](https://badge.fury.io/rb/terraform-enterprise-client.svg)](https://badge.fury.io/rb/terraform-enterprise-client)
[![Maintainability](https://api.codeclimate.com/v1/badges/1fd90e8dda31d1d402e8/maintainability)](https://codeclimate.com/github/skierkowski/terraform-enterprise-client/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/1fd90e8dda31d1d402e8/test_coverage)](https://codeclimate.com/github/skierkowski/terraform-enterprise-client/test_coverage)
[![Dependency Status](https://gemnasium.com/badges/github.com/skierkowski/terraform-enterprise-client.svg)](https://gemnasium.com/github.com/skierkowski/terraform-enterprise-client)
[![Inline docs](http://inch-ci.org/github/skierkowski/terraform-enterprise-client.svg?branch=master)](http://inch-ci.org/github/skierkowski/terraform-enterprise-client)

#### NOTE: The command line tool has moved to [skierkowski/terraform-enterprise-cli](https://github.com/skierkowski/terraform-enterprise-cli).

## Requirements

MRI Ruby 2.3 and newer are supported. Alternative interpreters compatible with 2.3+ should work as well.

This gem depends on these other gems for usage at runtime:

- [rest-client](https://github.com/rest-client/rest-client)

## API Client

### Usage



#### Basic Example

```ruby
require 'terraform-enterprise-client'

token = ENV['TFE_TOKEN']
client = TerraformEnterprise::API::Client.new(token: token)

# Create a new organization
org = client.organizations.create(name:'my-org',email:'maciej@skierkowski.com')

# Create a new workspace in the new organization.
# Uses the same parameters as the following docs:
# https://www.terraform.io/docs/enterprise/api/workspaces.html
client.workspaces.create(name:'my-new-workspace', organization:'my-org')

# Delete the workspace
client.workspaces.delete(name:'my-new-workspace', organization: 'my-org')

# Delete the organization now that we are done
client.organizations.delete(name:'my-org')
```



### Configuration

There are two main settings that can be modified on initialization:

- `:token` (required) - which specifies the API key (formerly called ATLAS_TOKEN)
- `:host` - a hostname other than the default (`app.terraform.io`) for usage with private installs
