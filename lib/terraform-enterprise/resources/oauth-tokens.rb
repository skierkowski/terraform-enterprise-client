require "terraform-enterprise/resources_client"

module TerraformEnterprise  
  class OAuthTokens < ResourcesClient
    def list(params={})
      @requst.get(:organizations, params[:organization], 'oauth-tokens')
    end
  end
end