require 'json'
require 'rest-client'

require 'terraform-enterprise/client/request'
require 'terraform-enterprise/resources/organizations'
require 'terraform-enterprise/resources/oauth-tokens'
require 'terraform-enterprise/resources/workspaces'

module TerraformEnterprise
  class Client
    attr_accessor :base

    def initialize(options={})
      @request = TerraformEnterprise::API::Request.new(options)
    end

    def workspaces
      TerraformEnterprise::Workspaces.new(@request)
    end

    def organizations
      TerraformEnterprise::Organizations.new(@request)
    end

    def oauth_tokens
      TerraformEnterprise::OAuthTokens.new(@request)
    end
  end
end