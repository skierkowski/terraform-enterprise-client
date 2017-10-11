require "terraform_enterprise_api/resources_client"

module TerraformEnterprise  
  class LinkableRepos < ResourcesClient
    def list(params={})
      org = params[:organization]
      
      @client.get('linkable-repos', filter:{organization:{username:org}})
    end
  end
end