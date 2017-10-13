require "terraform_enterprise_api/resources_client"

module TerraformEnterprise  
  class LinkableRepos < ResourcesClient
    def list(params={})
      org = params[:organization]
      
      @client.get('linkable-repos', filter:{organization:{username:org}})
    end

    def get(params={})
      org  = params[:organization]
      repo = params[:repository]
      
      results = @client.get('linkable-repos', filter:{organization:{username:org}})

      results.find{|r| r['attributes']['name'] == repo }
    end
  end
end