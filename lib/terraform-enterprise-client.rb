require 'json'
require 'rest-client'

require 'terraform-enterprise/client/request'
require 'terraform-enterprise/resource_requests/organizations'
require 'terraform-enterprise/resource_requests/oauth-tokens'
require 'terraform-enterprise/resource_requests/workspaces'
require 'terraform-enterprise/resource_requests/teams'

module TerraformEnterprise
  class Client
    attr_accessor :base

    def initialize(options={})
      @request = TerraformEnterprise::API::Request.new(options)
    end

    def oauth_tokens
      TerraformEnterprise::API::OAuthTokens.new(@request)
    end

    def organizations
      TerraformEnterprise::API::Organizations.new(@request)
    end

    def teams
      TerraformEnterprise::API::Teams.new(@request)
    end

      TerraformEnterprise::API::Workspaces.new(@request)
    end
  end
end