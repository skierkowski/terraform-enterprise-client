require 'json'
require 'rest-client'

require 'terraform-enterprise/client/request'
require 'terraform-enterprise/resource_requests/organizations'
require 'terraform-enterprise/resource_requests/oauth-tokens'
require 'terraform-enterprise/resource_requests/workspaces'

module TerraformEnterprise
  class Client
    attr_accessor :base

    def initialize(options={})
      @request = TerraformEnterprise::API::Request.new(options)
    end

    def workspaces
      TerraformEnterprise::API::Workspaces.new(@request)
    end

    def organizations
      TerraformEnterprise::API::Organizations.new(@request)
    end

    def oauth_tokens
      TerraformEnterprise::API::OAuthTokens.new(@request)
    end
  end
end