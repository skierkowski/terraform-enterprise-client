require "terraform_enterprise_api/resources_client"

module TerraformEnterprise  
  class Organizations < ResourcesClient
    def list(params={})
      org = params[:organization]
      @client.get(:organizations)
    end

    def get(parmas={})
      id = params[:organization]
      @client.get(:organizations, id)
    end
  end
end