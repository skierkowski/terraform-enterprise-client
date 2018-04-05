require 'json'
require 'rest-client'

require_relative 'request'
require_relative 'resource_requests/configuration_versions'
require_relative 'resource_requests/oauth_tokens'
require_relative 'resource_requests/organizations'
require_relative 'resource_requests/policies'
require_relative 'resource_requests/policy_checks'
require_relative 'resource_requests/runs'
require_relative 'resource_requests/teams'
require_relative 'resource_requests/variables'
require_relative 'resource_requests/workspaces'

module TerraformEnterprise
  module API
    # The Terraform Enterprise Client class
    class Client
      attr_accessor :base

      def initialize(options = {})
        @request = TerraformEnterprise::API::Request.new(options)
      end

      def configuration_versions
        TerraformEnterprise::API::ConfigurationVersions.new(@request)
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

      def variables
        TerraformEnterprise::API::Variables.new(@request)
      end

      def workspaces
        TerraformEnterprise::API::Workspaces.new(@request)
      end

      def policies
        TerraformEnterprise::API::Policies.new(@request)
      end

      def policy_checks
        TerraformEnterprise::API::PolicyChecks.new(@request)
      end

      def runs
        TerraformEnterprise::API::Runs.new(@request)
      end
    end
  end
end
