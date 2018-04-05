require 'terraform_enterprise/api/resource_request'

module TerraformEnterprise
  module API
    # OAuth Token resource request
    class OAuthTokens < TerraformEnterprise::API::ResourceRequest
      def list(params = {})
        @request.get(:organizations, params[:organization], 'oauth-tokens')
      end
    end
  end
end
