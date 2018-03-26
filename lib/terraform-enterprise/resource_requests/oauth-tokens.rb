require "terraform-enterprise/client/resource_request"

module TerraformEnterprise  
  module API
    class OAuthTokens < TerraformEnterprise::API::ResourceRequest
      def list(params={})
        @request.get(:organizations, params[:organization], 'oauth-tokens')
      end
    end
  end
end